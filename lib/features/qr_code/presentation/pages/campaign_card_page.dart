import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../qr_code/presentation/bloc/qr_cubit.dart';
import '../../../campaigns/domain/entities/campaign.dart';

/// Shareable campaign card generator.
/// Pass a [campaign] to pre-fill from an existing campaign,
/// or null to use the standalone occasion picker (original behaviour).
class CampaignCardPage extends StatefulWidget {
  final Campaign? campaign;
  const CampaignCardPage({super.key, this.campaign});

  @override
  State<CampaignCardPage> createState() => _CampaignCardPageState();
}

class _CampaignCardPageState extends State<CampaignCardPage> {
  late int _selectedIndex;
  late final TextEditingController _msgController;
  late final TextEditingController _customOccasionController;
  final _cardKey = GlobalKey();
  bool _sharing = false;

  // Maps CampaignCategory to the local _occasions list index
  static const _occasions = [
    _Occasion(emoji: '🎂', label: 'Birthday',    gradient: [Color(0xFFFF6B9D), Color(0xFFFF8E53)], defaultMessage: "It's my birthday! A tip would be the best gift 🎁"),
    _Occasion(emoji: '🎄', label: 'Christmas',   gradient: [Color(0xFF2ECC71), Color(0xFF1A8A4A)], defaultMessage: 'Wishing you a Merry Christmas! 🎅 Tips are welcome!'),
    _Occasion(emoji: '🥂', label: 'Anniversary', gradient: [Color(0xFF6C4EE8), Color(0xFFB44FE8)], defaultMessage: 'Celebrating my work anniversary! Thank you for your support 🙏'),
    _Occasion(emoji: '🎉', label: 'New Year',    gradient: [Color(0xFFF59E0B), Color(0xFFEF4444)], defaultMessage: 'Happy New Year! Start the year by spreading kindness 🌟'),
    _Occasion(emoji: '🙏', label: 'Thank You',   gradient: [Color(0xFF3B82F6), Color(0xFF6C4EE8)], defaultMessage: 'Thank you for your generosity and support! It means the world to me.'),
    _Occasion(emoji: '✨', label: 'Custom',      gradient: [Color(0xFF8B72F0), Color(0xFF5E3DD0)], defaultMessage: ''),
  ];

  @override
  void initState() {
    super.initState();
    final c = widget.campaign;
    // Pre-fill from campaign if provided
    _selectedIndex = c != null ? _indexForCategory(c.category) : 0;
    _msgController = TextEditingController(
      text: c?.description.isNotEmpty == true
          ? c!.description
          : _occasions[_selectedIndex].defaultMessage,
    );
    _customOccasionController = TextEditingController(
      text: c?.category == CampaignCategory.other ? (c?.title ?? '') : '',
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final qrState = context.read<QrCubit>().state;
      if (qrState is QrInitial || qrState is QrError) {
        context.read<QrCubit>().loadQrCode();
      }
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
    _customOccasionController.dispose();
    super.dispose();
  }

  int _indexForCategory(CampaignCategory cat) {
    switch (cat) {
      case CampaignCategory.birthday:    return 0;
      case CampaignCategory.christmas:   return 1;
      case CampaignCategory.anniversary: return 2;
      case CampaignCategory.holiday:     return 3;
      case CampaignCategory.other:       return 5;
      default:                           return 5;
    }
  }

  void _selectOccasion(int i) {
    setState(() {
      _selectedIndex = i;
      if (_occasions[i].defaultMessage.isNotEmpty) {
        _msgController.text = _occasions[i].defaultMessage;
      }
    });
  }

  Future<void> _share(String name) async {
    setState(() => _sharing = true);
    try {
      final boundary =
          _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
      final dir = await getTemporaryDirectory();
      final file =
          await File('${dir.path}/amtips_campaign.png').writeAsBytes(bytes);
      final occ = _occasions[_selectedIndex];
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text:
              '${occ.emoji} ${_msgController.text.trim().isNotEmpty ? _msgController.text.trim() : occ.defaultMessage}\n\nTip me on amTips!',
          subject: 'Support $name on amTips',
        ),
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campaign Card')),
      body: BlocBuilder<QrCubit, QrState>(
        builder: (context, qrState) {
          final qrUrl = qrState is QrLoaded
              ? qrState.qrCode.url
              : qrState is QrSharing
                  ? qrState.qrCode.url
                  : null;

          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              final profile =
                  profileState is ProfileLoaded ? profileState.profile : null;
              final name = profile?.fullName ?? '';
              final avatarUrl = profile?.avatarUrl;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Occasion picker ──────────────────────────────────
                    Text('Choose occasion', style: AppTextStyles.labelMedium),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 84,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _occasions.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, i) {
                          final occ = _occasions[i];
                          final selected = i == _selectedIndex;
                          return GestureDetector(
                            onTap: () => _selectOccasion(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 72,
                              height: 84,
                              decoration: BoxDecoration(
                                gradient: selected
                                    ? LinearGradient(
                                        colors: occ.gradient,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                color: selected
                                    ? null
                                    : Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(16),
                                border: selected
                                    ? null
                                    : Border.all(
                                        color: AppColors.divider, width: 1.5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(occ.emoji,
                                      style: const TextStyle(fontSize: 24)),
                                  const SizedBox(height: 2),
                                  Text(
                                    occ.label,
                                    style: AppTextStyles.caption.copyWith(
                                      color: selected
                                          ? Colors.white
                                          : AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Custom occasion label ────────────────────────────
                    if (_selectedIndex == 5) ...[
                      Text('Occasion name', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _customOccasionController,
                        maxLength: 40,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'e.g. Graduation, Ramadan, Work trip…',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // ── Message ──────────────────────────────────────────
                    Text('Your message', style: AppTextStyles.labelMedium),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _msgController,
                      maxLines: 2,
                      maxLength: 120,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Write something heartfelt…',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Card preview ─────────────────────────────────────
                    Text('Preview', style: AppTextStyles.labelMedium),
                    const SizedBox(height: 10),

                    if (qrUrl == null)
                      const Center(child: CircularProgressIndicator())
                    else
                      RepaintBoundary(
                        key: _cardKey,
                        child: _ShareCard(
                          occasion: _occasions[_selectedIndex],
                          customLabel: _selectedIndex == 5
                              ? _customOccasionController.text.trim()
                              : null,
                          name: name,
                          avatarUrl: avatarUrl,
                          message: _msgController.text.trim().isNotEmpty
                              ? _msgController.text.trim()
                              : _occasions[_selectedIndex].defaultMessage,
                          qrUrl: qrUrl,
                          campaign: widget.campaign,
                        ),
                      ),

                    const SizedBox(height: 24),

                    AppButton(
                      label: 'Share Campaign Card',
                      isLoading: _sharing,
                      onPressed: qrUrl == null ? null : () => _share(name),
                      prefixIcon: const Icon(Icons.share_rounded,
                          size: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ── Data class ────────────────────────────────────────────────────────────────

class _Occasion {
  final String emoji;
  final String label;
  final List<Color> gradient;
  final String defaultMessage;
  const _Occasion({
    required this.emoji,
    required this.label,
    required this.gradient,
    required this.defaultMessage,
  });
}

// ── Shareable card ────────────────────────────────────────────────────────────

class _ShareCard extends StatelessWidget {
  final _Occasion occasion;
  final String? customLabel;
  final String name;
  final String? avatarUrl;
  final String message;
  final String qrUrl;
  final Campaign? campaign;

  const _ShareCard({
    required this.occasion,
    this.customLabel,
    required this.name,
    required this.avatarUrl,
    required this.message,
    required this.qrUrl,
    this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    final hasGoal = campaign != null &&
        campaign!.targetAmount != null &&
        campaign!.targetAmount! > 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Gradient banner ──────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: occasion.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                // Avatar + emoji badge
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        color: Colors.white24,
                      ),
                      child: ClipOval(
                        child: avatarUrl != null && avatarUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: avatarUrl!,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) =>
                                    _AvatarFallback(name: name),
                              )
                            : _AvatarFallback(name: name),
                      ),
                    ),
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Center(
                        child: Text(occasion.emoji,
                            style: const TextStyle(fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (name.isNotEmpty)
                  Text(
                    name,
                    style: AppTextStyles.h2.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 6),
                Text(
                  customLabel != null && customLabel!.isNotEmpty
                      ? '${occasion.emoji} $customLabel'
                      : '${occasion.emoji} ${occasion.label}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.80),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: Colors.white.withValues(alpha: 0.92)),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // ── Progress bar (only when campaign has a goal) ──────────
                if (hasGoal) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              campaign!.formattedRaised,
                              style: AppTextStyles.labelMedium
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              'Goal: ${campaign!.formattedTarget}',
                              style: AppTextStyles.labelSmall
                                  .copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: campaign!.progress,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.25),
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.white),
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${campaign!.progressPercentage}% reached · ${campaign!.tipsCount} tips',
                          style: AppTextStyles.caption
                              .copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── QR section ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
            child: Column(
              children: [
                Text(
                  'Scan to leave a tip',
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.divider, width: 1.5),
                  ),
                  child: QrImageView(
                    data: qrUrl,
                    version: QrVersions.auto,
                    size: 160,
                    backgroundColor: Colors.white,
                    eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: occasion.gradient.last,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: occasion.gradient.last,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: occasion.gradient),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.monetization_on_rounded,
                          size: 12, color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    Text('amTips',
                        style: AppTextStyles.labelSmall
                            .copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  final String name;
  const _AvatarFallback({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primarySurface,
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: AppTextStyles.h2.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
