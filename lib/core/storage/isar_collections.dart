import 'package:isar_community/isar.dart';

part 'isar_collections.g.dart';

@collection
class CachedProfile {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String userId;

  late String profileId;
  late String fullName;
  String? avatarUrl;
  late String restaurantName;
  late String city;
  late String country;
  String? personalMessage;
  late double averageRating;
  late int totalRatings;
  late String qrToken;
  late List<String> professions;
  late bool isActive;

  String? paymentAccountId;
  String? paymentAccountType;
  String? paymentAccountProvider;
  String? paymentAccountIdentifier;
  bool paymentAccountIsActive = true;

  DateTime? createdAt;
  DateTime? updatedAt;
  late DateTime cachedAt;
}

@collection
class CachedTip {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  @Index()
  late String waiterId;

  late int amount;
  late String currency;
  late String status;
  String? message;
  int? rating;
  String? transactionReference;
  String? paymentProvider;
  late bool isAnonymous;
  String? customerName;
  late DateTime createdAt;
  DateTime? updatedAt;
}

@collection
class CachedTipStats {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String waiterId;

  late int todayTotal;
  late int weekTotal;
  late int allTimeTotal;
  late String currency;
  late int todayCount;
  late int weekCount;
  late int allTimeCount;
  late DateTime cachedAt;
}

@collection
class CachedWallet {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String waiterId;

  late int availableBalance;
  late int pendingBalance;
  late String currency;
  late DateTime cachedAt;
}

@collection
class CachedWalletTransaction {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  @Index()
  late String waiterId;

  late String type;
  late int amount;
  late String currency;
  late String status;
  String? description;
  String? reference;
  late DateTime createdAt;
}

@collection
class CachedNotification {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  late String title;
  late String body;
  late String type;
  late bool isRead;
  String? dataJson;
  late DateTime createdAt;
}

@collection
class CachedQrCode {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String waiterId;

  late String url;
  late String qrToken;
  late DateTime cachedAt;
}

@collection
class CachedWithdrawal {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  late int amount;
  late String currency;
  late String status;
  String? paymentAccountId;
  String? failureReason;
  late DateTime createdAt;
}
