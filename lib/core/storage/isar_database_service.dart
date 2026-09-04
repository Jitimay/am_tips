import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/campaigns/domain/entities/campaign.dart';
import '../../features/notifications/domain/entities/notification.dart';
import '../../features/profile/domain/entities/waiter_profile.dart';
import '../../features/qr_code/domain/entities/qr_code.dart';
import '../../features/tips/domain/entities/tip.dart';
import '../../features/tips/domain/entities/wallet.dart';
import '../../features/withdrawals/domain/entities/withdrawal.dart';
import 'isar_collections.dart';

class IsarDatabaseService {
  Isar? _isar;

  Future<Isar> get db async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }
    _isar = await _init();
    return _isar!;
  }

  Future<Isar> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [
        CachedProfileSchema,
        CachedTipSchema,
        CachedTipStatsSchema,
        CachedWalletSchema,
        CachedWalletTransactionSchema,
        CachedNotificationSchema,
        CachedQrCodeSchema,
        CachedWithdrawalSchema,
        CachedCampaignSchema,
      ],
      directory: dir.path,
      name: 'amtips_offline_db',
      inspector: false,
    );
  }

  // ── Profile ────────────────────────────────────────────────────────────────

  Future<void> saveProfile(WaiterProfile profile) async {
    try {
      final isar = await db;
      final cached = CachedProfile()
        ..userId = profile.userId
        ..profileId = profile.id
        ..fullName = profile.fullName
        ..avatarUrl = profile.avatarUrl
        ..restaurantName = profile.restaurantName
        ..city = profile.city
        ..country = profile.country
        ..personalMessage = profile.personalMessage
        ..averageRating = profile.averageRating
        ..totalRatings = profile.totalRatings
        ..qrToken = profile.qrToken
        ..professions = profile.professions
        ..isActive = profile.isActive
        ..paymentAccountId = profile.connectedPaymentAccount?.id
        ..paymentAccountType = profile.connectedPaymentAccount?.type
        ..paymentAccountProvider = profile.connectedPaymentAccount?.provider
        ..paymentAccountIdentifier =
            profile.connectedPaymentAccount?.accountIdentifier
        ..paymentAccountIsActive =
            profile.connectedPaymentAccount?.isActive ?? true
        ..createdAt = profile.createdAt
        ..updatedAt = profile.updatedAt
        ..cachedAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.cachedProfiles.putByUserId(cached);
      });
    } catch (e) {
      debugPrint('[Isar] saveProfile error: $e');
    }
  }

  Future<WaiterProfile?> getProfile({String? userId}) async {
    try {
      final isar = await db;
      CachedProfile? cached;
      if (userId != null && userId.isNotEmpty) {
        cached = await isar.cachedProfiles.getByUserId(userId);
      }
      cached ??= await isar.cachedProfiles.where().findFirst();
      if (cached == null) return null;

      PaymentAccountInfo? paymentAccount;
      if (cached.paymentAccountId != null &&
          cached.paymentAccountType != null &&
          cached.paymentAccountProvider != null &&
          cached.paymentAccountIdentifier != null) {
        paymentAccount = PaymentAccountInfo(
          id: cached.paymentAccountId!,
          type: cached.paymentAccountType!,
          provider: cached.paymentAccountProvider!,
          accountIdentifier: cached.paymentAccountIdentifier!,
          isActive: cached.paymentAccountIsActive,
        );
      }

      return WaiterProfile(
        id: cached.profileId,
        userId: cached.userId,
        fullName: cached.fullName,
        avatarUrl: cached.avatarUrl,
        restaurantName: cached.restaurantName,
        city: cached.city,
        country: cached.country,
        personalMessage: cached.personalMessage,
        averageRating: cached.averageRating,
        totalRatings: cached.totalRatings,
        qrToken: cached.qrToken,
        professions: cached.professions,
        isActive: cached.isActive,
        connectedPaymentAccount: paymentAccount,
        createdAt: cached.createdAt ?? DateTime.now(),
        updatedAt: cached.updatedAt,
      );
    } catch (e) {
      debugPrint('[Isar] getProfile error: $e');
      return null;
    }
  }

  // ── Tips ───────────────────────────────────────────────────────────────────

  Future<void> saveTips(List<Tip> tips, String waiterId) async {
    try {
      final isar = await db;
      final cachedList = tips.map((t) {
        return CachedTip()
          ..id = t.id
          ..waiterId = t.waiterId.isNotEmpty ? t.waiterId : waiterId
          ..amount = t.amount
          ..currency = t.currency
          ..status = t.status.name
          ..message = t.message
          ..rating = t.rating
          ..transactionReference = t.transactionReference
          ..paymentProvider = t.paymentProvider
          ..isAnonymous = t.isAnonymous
          ..customerName = t.customerName
          ..createdAt = t.createdAt
          ..updatedAt = t.updatedAt;
      }).toList();

      await isar.writeTxn(() async {
        for (final item in cachedList) {
          await isar.cachedTips.putById(item);
        }
      });
    } catch (e) {
      debugPrint('[Isar] saveTips error: $e');
    }
  }

  Future<void> saveTip(Tip tip) async {
    await saveTips([tip], tip.waiterId);
  }

  Future<List<Tip>> getTips({
    String? waiterId,
    String? filter,
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final isar = await db;
      var query = isar.cachedTips.where();
      List<CachedTip> results;

      if (waiterId != null && waiterId.isNotEmpty) {
        results = await query
            .filter()
            .waiterIdEqualTo(waiterId)
            .sortByCreatedAtDesc()
            .offset((page - 1) * pageSize)
            .limit(pageSize)
            .findAll();
      } else {
        results = await query
            .sortByCreatedAtDesc()
            .offset((page - 1) * pageSize)
            .limit(pageSize)
            .findAll();
      }

      // Filter in memory if needed
      final now = DateTime.now();
      if (filter == 'today') {
        final startOfDay = DateTime(now.year, now.month, now.day);
        results = results.where((t) => t.createdAt.isAfter(startOfDay)).toList();
      } else if (filter == 'week') {
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final start = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
        results = results.where((t) => t.createdAt.isAfter(start)).toList();
      } else if (filter == 'month') {
        final startOfMonth = DateTime(now.year, now.month, 1);
        results = results.where((t) => t.createdAt.isAfter(startOfMonth)).toList();
      }

      return results.map((c) {
        return Tip(
          id: c.id,
          waiterId: c.waiterId,
          amount: c.amount,
          currency: c.currency,
          status: _parseTipStatus(c.status),
          message: c.message,
          rating: c.rating,
          transactionReference: c.transactionReference,
          paymentProvider: c.paymentProvider,
          isAnonymous: c.isAnonymous,
          customerName: c.customerName,
          createdAt: c.createdAt,
          updatedAt: c.updatedAt,
        );
      }).toList();
    } catch (e) {
      debugPrint('[Isar] getTips error: $e');
      return [];
    }
  }

  Future<Tip?> getTip(String id) async {
    try {
      final isar = await db;
      final c = await isar.cachedTips.getById(id);
      if (c == null) return null;
      return Tip(
        id: c.id,
        waiterId: c.waiterId,
        amount: c.amount,
        currency: c.currency,
        status: _parseTipStatus(c.status),
        message: c.message,
        rating: c.rating,
        transactionReference: c.transactionReference,
        paymentProvider: c.paymentProvider,
        isAnonymous: c.isAnonymous,
        customerName: c.customerName,
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
      );
    } catch (e) {
      debugPrint('[Isar] getTip error: $e');
      return null;
    }
  }

  TipStatus _parseTipStatus(String status) {
    return TipStatus.values.firstWhere(
      (e) => e.name == status.toLowerCase(),
      orElse: () => TipStatus.pending,
    );
  }

  // ── Tip Stats ──────────────────────────────────────────────────────────────

  Future<void> saveTipStats(TipStats stats, String waiterId) async {
    try {
      final isar = await db;
      final cached = CachedTipStats()
        ..waiterId = waiterId
        ..todayTotal = stats.todayTotal
        ..weekTotal = stats.weekTotal
        ..allTimeTotal = stats.allTimeTotal
        ..currency = stats.currency
        ..todayCount = stats.todayCount
        ..weekCount = stats.weekCount
        ..allTimeCount = stats.allTimeCount
        ..cachedAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.cachedTipStats.putByWaiterId(cached);
      });
    } catch (e) {
      debugPrint('[Isar] saveTipStats error: $e');
    }
  }

  Future<TipStats?> getTipStats({String? waiterId}) async {
    try {
      final isar = await db;
      CachedTipStats? cached;
      if (waiterId != null && waiterId.isNotEmpty) {
        cached = await isar.cachedTipStats.getByWaiterId(waiterId);
      }
      cached ??= await isar.cachedTipStats.where().findFirst();
      if (cached == null) return null;

      return TipStats(
        todayTotal: cached.todayTotal,
        weekTotal: cached.weekTotal,
        allTimeTotal: cached.allTimeTotal,
        currency: cached.currency,
        todayCount: cached.todayCount,
        weekCount: cached.weekCount,
        allTimeCount: cached.allTimeCount,
      );
    } catch (e) {
      debugPrint('[Isar] getTipStats error: $e');
      return null;
    }
  }

  // ── Wallet ─────────────────────────────────────────────────────────────────

  Future<void> saveWallet(Wallet wallet, String waiterId) async {
    try {
      final isar = await db;
      final cached = CachedWallet()
        ..waiterId = wallet.waiterId.isNotEmpty ? wallet.waiterId : waiterId
        ..availableBalance = wallet.availableBalance
        ..pendingBalance = wallet.pendingBalance
        ..currency = wallet.currency
        ..cachedAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.cachedWallets.putByWaiterId(cached);
      });
    } catch (e) {
      debugPrint('[Isar] saveWallet error: $e');
    }
  }

  Future<Wallet?> getWallet({String? waiterId}) async {
    try {
      final isar = await db;
      CachedWallet? cached;
      if (waiterId != null && waiterId.isNotEmpty) {
        cached = await isar.cachedWallets.getByWaiterId(waiterId);
      }
      cached ??= await isar.cachedWallets.where().findFirst();
      if (cached == null) return null;

      return Wallet(
        waiterId: cached.waiterId,
        availableBalance: cached.availableBalance,
        pendingBalance: cached.pendingBalance,
        currency: cached.currency,
        lastUpdatedAt: cached.cachedAt,
      );
    } catch (e) {
      debugPrint('[Isar] getWallet error: $e');
      return null;
    }
  }

  // ── Wallet Transactions ───────────────────────────────────────────────────

  Future<void> saveTransactions(
      List<WalletTransaction> transactions, String waiterId) async {
    try {
      final isar = await db;
      final cachedList = transactions.map((t) {
        return CachedWalletTransaction()
          ..id = t.id
          ..waiterId = waiterId
          ..type = t.type.name
          ..amount = t.amount
          ..currency = t.currency
          ..status = t.isCredit ? 'credit' : 'debit'
          ..description = t.description
          ..reference = t.reference
          ..createdAt = t.createdAt;
      }).toList();

      await isar.writeTxn(() async {
        for (final item in cachedList) {
          await isar.cachedWalletTransactions.putById(item);
        }
      });
    } catch (e) {
      debugPrint('[Isar] saveTransactions error: $e');
    }
  }

  Future<List<WalletTransaction>> getTransactions({
    String? waiterId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final isar = await db;
      var query = isar.cachedWalletTransactions.where();
      List<CachedWalletTransaction> results;

      if (waiterId != null && waiterId.isNotEmpty) {
        results = await query
            .filter()
            .waiterIdEqualTo(waiterId)
            .sortByCreatedAtDesc()
            .offset((page - 1) * pageSize)
            .limit(pageSize)
            .findAll();
      } else {
        results = await query
            .sortByCreatedAtDesc()
            .offset((page - 1) * pageSize)
            .limit(pageSize)
            .findAll();
      }

      return results.map((c) {
        final isCredit = c.status == 'credit';
        return WalletTransaction(
          id: c.id,
          type: _parseTransactionType(c.type),
          amount: c.amount,
          currency: c.currency,
          isCredit: isCredit,
          description: c.description,
          reference: c.reference,
          createdAt: c.createdAt,
        );
      }).toList();
    } catch (e) {
      debugPrint('[Isar] getTransactions error: $e');
      return [];
    }
  }

  TransactionType _parseTransactionType(String type) {
    return TransactionType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => TransactionType.tipReceived,
    );
  }

  // ── Notifications ──────────────────────────────────────────────────────────

  Future<void> saveNotifications(List<AppNotification> notifications) async {
    try {
      final isar = await db;
      final cachedList = notifications.map((n) {
        return CachedNotification()
          ..id = n.id
          ..title = n.title
          ..body = n.body
          ..type = n.type.name
          ..isRead = n.isRead
          ..dataJson = n.metadata != null ? jsonEncode(n.metadata) : null
          ..createdAt = n.createdAt;
      }).toList();

      await isar.writeTxn(() async {
        for (final item in cachedList) {
          await isar.cachedNotifications.putById(item);
        }
      });
    } catch (e) {
      debugPrint('[Isar] saveNotifications error: $e');
    }
  }

  Future<List<AppNotification>> getNotifications({
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final isar = await db;
      final results = await isar.cachedNotifications
          .where()
          .sortByCreatedAtDesc()
          .offset((page - 1) * pageSize)
          .limit(pageSize)
          .findAll();

      return results.map((c) {
        Map<String, dynamic>? metadata;
        if (c.dataJson != null) {
          try {
            metadata = Map<String, dynamic>.from(jsonDecode(c.dataJson!));
          } catch (_) {}
        }
        return AppNotification(
          id: c.id,
          type: _parseNotificationType(c.type),
          title: c.title,
          body: c.body,
          isRead: c.isRead,
          metadata: metadata,
          createdAt: c.createdAt,
        );
      }).toList();
    } catch (e) {
      debugPrint('[Isar] getNotifications error: $e');
      return [];
    }
  }

  Future<int> getUnreadNotificationCount() async {
    try {
      final isar = await db;
      return await isar.cachedNotifications.filter().isReadEqualTo(false).count();
    } catch (e) {
      debugPrint('[Isar] getUnreadNotificationCount error: $e');
      return 0;
    }
  }

  Future<void> markNotificationAsRead(String id) async {
    try {
      final isar = await db;
      final notif = await isar.cachedNotifications.getById(id);
      if (notif != null) {
        notif.isRead = true;
        await isar.writeTxn(() async {
          await isar.cachedNotifications.putById(notif);
        });
      }
    } catch (e) {
      debugPrint('[Isar] markNotificationAsRead error: $e');
    }
  }

  Future<void> markAllNotificationsAsRead() async {
    try {
      final isar = await db;
      final unread = await isar.cachedNotifications
          .filter()
          .isReadEqualTo(false)
          .findAll();
      for (final n in unread) {
        n.isRead = true;
      }
      await isar.writeTxn(() async {
        for (final n in unread) {
          await isar.cachedNotifications.putById(n);
        }
      });
    } catch (e) {
      debugPrint('[Isar] markAllNotificationsAsRead error: $e');
    }
  }

  NotificationType _parseNotificationType(String type) {
    return NotificationType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => NotificationType.system,
    );
  }

  // ── QR Code ────────────────────────────────────────────────────────────────

  Future<void> saveQrCode(QrCode qrCode, String waiterId) async {
    try {
      final isar = await db;
      final cached = CachedQrCode()
        ..waiterId = qrCode.waiterId.isNotEmpty ? qrCode.waiterId : waiterId
        ..url = qrCode.url
        ..qrToken = qrCode.token
        ..cachedAt = qrCode.generatedAt;

      await isar.writeTxn(() async {
        await isar.cachedQrCodes.putByWaiterId(cached);
      });
    } catch (e) {
      debugPrint('[Isar] saveQrCode error: $e');
    }
  }

  Future<QrCode?> getQrCode({String? waiterId}) async {
    try {
      final isar = await db;
      CachedQrCode? cached;
      if (waiterId != null && waiterId.isNotEmpty) {
        cached = await isar.cachedQrCodes.getByWaiterId(waiterId);
      }
      cached ??= await isar.cachedQrCodes.where().findFirst();
      if (cached == null) return null;

      return QrCode(
        waiterId: cached.waiterId,
        token: cached.qrToken,
        url: cached.url,
        generatedAt: cached.cachedAt,
      );
    } catch (e) {
      debugPrint('[Isar] getQrCode error: $e');
      return null;
    }
  }

  // ── Withdrawals ────────────────────────────────────────────────────────────

  Future<void> saveWithdrawals(List<Withdrawal> withdrawals) async {
    try {
      final isar = await db;
      final cachedList = withdrawals.map((w) {
        return CachedWithdrawal()
          ..id = w.id
          ..amount = w.amount
          ..currency = w.currency
          ..status = w.status.name
          ..paymentAccountId = w.paymentAccountId
          ..failureReason = w.failureReason
          ..createdAt = w.createdAt;
      }).toList();

      await isar.writeTxn(() async {
        for (final item in cachedList) {
          await isar.cachedWithdrawals.putById(item);
        }
      });
    } catch (e) {
      debugPrint('[Isar] saveWithdrawals error: $e');
    }
  }

  Future<void> saveWithdrawal(Withdrawal withdrawal) async {
    await saveWithdrawals([withdrawal]);
  }

  Future<List<Withdrawal>> getWithdrawals({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final isar = await db;
      final results = await isar.cachedWithdrawals
          .where()
          .sortByCreatedAtDesc()
          .offset((page - 1) * pageSize)
          .limit(pageSize)
          .findAll();

      return results.map((c) {
        return Withdrawal(
          id: c.id,
          waiterId: '',
          amount: c.amount,
          currency: c.currency,
          status: _parseWithdrawalStatus(c.status),
          paymentAccountId: c.paymentAccountId ?? '',
          failureReason: c.failureReason,
          createdAt: c.createdAt,
        );
      }).toList();
    } catch (e) {
      debugPrint('[Isar] getWithdrawals error: $e');
      return [];
    }
  }

  Future<Withdrawal?> getWithdrawal(String id) async {
    try {
      final isar = await db;
      final c = await isar.cachedWithdrawals.getById(id);
      if (c == null) return null;
      return Withdrawal(
        id: c.id,
        waiterId: '',
        amount: c.amount,
        currency: c.currency,
        status: _parseWithdrawalStatus(c.status),
        paymentAccountId: c.paymentAccountId ?? '',
        failureReason: c.failureReason,
        createdAt: c.createdAt,
      );
    } catch (e) {
      debugPrint('[Isar] getWithdrawal error: $e');
      return null;
    }
  }

  WithdrawalStatus _parseWithdrawalStatus(String status) {
    return WithdrawalStatus.values.firstWhere(
      (e) => e.name == status.toLowerCase(),
      orElse: () => WithdrawalStatus.requested,
    );
  }

  // ── Campaigns ──────────────────────────────────────────────────────────────

  Future<void> saveCampaigns(List<Campaign> campaigns) async {
    try {
      final isar = await db;
      final cachedList = campaigns.map((c) => CachedCampaign()
        ..id = c.id
        ..waiterId = c.waiterId
        ..title = c.title
        ..category = c.category.name
        ..description = c.description
        ..emoji = c.emoji
        ..targetAmount = c.targetAmount
        ..currentAmount = c.currentAmount
        ..tipsCount = c.tipsCount
        ..currency = c.currency
        ..isActive = c.isActive
        ..startDate = c.startDate
        ..endDate = c.endDate
        ..createdAt = c.createdAt
        ..updatedAt = c.updatedAt
        ..cachedAt = DateTime.now()).toList();

      await isar.writeTxn(() async {
        for (final item in cachedList) {
          await isar.cachedCampaigns.putById(item);
        }
      });
    } catch (e) {
      debugPrint('[Isar] saveCampaigns error: $e');
    }
  }

  Future<void> saveCampaign(Campaign campaign) async => saveCampaigns([campaign]);

  Future<List<Campaign>> getCampaigns({bool? activeOnly}) async {
    try {
      final isar = await db;
      List<CachedCampaign> results;
      if (activeOnly == true) {
        results = await isar.cachedCampaigns.filter()
            .isActiveEqualTo(true).sortByCreatedAtDesc().findAll();
      } else {
        results = await isar.cachedCampaigns.where()
            .sortByCreatedAtDesc().findAll();
      }
      return results.map(_campaignFromCache).toList();
    } catch (e) {
      debugPrint('[Isar] getCampaigns error: $e');
      return [];
    }
  }

  Future<Campaign?> getCampaign(String id) async {
    try {
      final isar = await db;
      final c = await isar.cachedCampaigns.getById(id);
      return c == null ? null : _campaignFromCache(c);
    } catch (e) {
      debugPrint('[Isar] getCampaign error: $e');
      return null;
    }
  }

  Future<void> deleteCachedCampaign(String id) async {
    try {
      final isar = await db;
      await isar.writeTxn(() => isar.cachedCampaigns.deleteById(id));
    } catch (e) {
      debugPrint('[Isar] deleteCachedCampaign error: $e');
    }
  }

  Campaign _campaignFromCache(CachedCampaign c) => Campaign(
        id: c.id,
        waiterId: c.waiterId,
        title: c.title,
        category: CampaignCategory.fromString(c.category),
        description: c.description,
        emoji: c.emoji,
        targetAmount: c.targetAmount,
        currentAmount: c.currentAmount,
        tipsCount: c.tipsCount,
        currency: c.currency,
        isActive: c.isActive,
        startDate: c.startDate,
        endDate: c.endDate,
        createdAt: c.createdAt,
        updatedAt: c.updatedAt,
      );

  // ── Clear Database ────────────────────────────────────────────────────────

  Future<void> clearAll() async {
    try {
      final isar = await db;
      await isar.writeTxn(() async {
        await isar.cachedProfiles.clear();
        await isar.cachedTips.clear();
        await isar.cachedTipStats.clear();
        await isar.cachedWallets.clear();
        await isar.cachedWalletTransactions.clear();
        await isar.cachedNotifications.clear();
        await isar.cachedQrCodes.clear();
        await isar.cachedWithdrawals.clear();
        await isar.cachedCampaigns.clear();
      });
    } catch (e) {
      debugPrint('[Isar] clearAll error: $e');
    }
  }
}
