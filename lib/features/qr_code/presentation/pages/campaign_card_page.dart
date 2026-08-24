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
import '../bloc/qr_cubit.dart';

// ── Campaign types ─────────────────────────────────────────────────────────

class _Campaign {
  final String emoji;
  final String label;
  final List<Color> gradient;
  final String defaultMessage;

  const _Campaign({
    required this.emoji,
    required this.label,
    required this.gradient,
    required this.defaultMessage,
  });
}

const _campaigns = [
  _Campaign(
    emoji: '🎂',
    label: 'Birthday',
    gradient: [Color(0xFFFF6B9D), Color(0xFFFF8E53)],
    defaultMessage: "It's my birthday! A tip would be the best gift 🎁",
  ),
  _Campaign(
    emoji: '🎄',
    label: 'Christmas',
    gradient: [Color(0xFF2ECC71), Color(0xFF1A8A4A)],
    defaultMessage: 'Wishing you a Merry Christmas! 🎅 Tips are welcome!',
  ),
  _Campaign(
    emoji: '🥂',
    label: 'Anniversary',
    gradient: [Color(0xFF6C4EE8), Color(0xFFB44FE8)],
    defaultMessage: 'Celebrating my work anniversary! Thank you for your support 🙏',
  ),
  _Campaign(
    emoji: '🎉',
    label: 'New Year',
    gradient: [Color(0xFFF59E0B), Color(0xFFEF4444)],
    defaultMessage: 'Happy New Year! Start the year by spreading kindness 🌟',
  ),
  _Campaign(
    emoji: '🙏',
    label: 'Thank You',
    gradient: [Color(0xFF3B82F6), Color(0xFF6C4EE8)],
    defaultMessage: 'Thank you for your generosity and support! It means the world to me.',
  ),
  _Campaign(
    emoji: '✨',
    label: 'Custom',
    gradient: [Color(0xFF8B72F0), Color(0xFF5E3DD0)],
    defaultMessage: '',
  ),
];

// ── Page ───────────────────────────────────────────────────────────────────

class CampaignCardPage extends StatefulWidget {
  const CampaignCardPage({super.key});

  @override
  State<CampaignCardPage> createState() => _CampaignCardPageState();
}

class _CampaignCardPageState extends State<CampaignCardPage> {
  int _selectedIndex = 0;
  final _msgController = TextEditingController();
  final _customOccasionController = TextEditingController();
  final _cardKey = GlobalKey();
  bool _sharing = false;

  @override
  void initState() {
    super.initState();
    _msgController.text = _campaigns[0].defaultMessage;
    // ensure QR is loaded so the preview renders
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

  void _selectCampaign(int i) {
    setState(() {
      _selectedIndex = i;
      if (_campaigns[i].defaultMessage.isNotEmpty) {
        _msgController.text = _campaigns[i].defaultMessage;
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
      final bytes =
          (await image.toByteData(format: ui.ImageByteFormat.png))!
              .buffer
              .asUint8List();
      final dir = await getTemporaryDirectory();
      final file =
          await File('${dir.path}/amtips_campaign.png').writeAsBytes(bytes);
      final campaign = _campaigns[_selectedIndex];
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text:
              '${campaign.emoji} ${_msgController.text.trim().isNotEmpty ? _msgController.text.trim() : campaign.defaultMessage}\n\nTip me on amTips!',
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
                    // ── Campaign picker ──────────────────────────────────
                    Text('Choose occasion',
                        style: AppTextStyles.labelMedium),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 84,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _campaigns.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (_, i) {
                                final c = _campaigns[i];
                                final selected = i == _selectedIndex;
                                return GestureDetector(
                                  onTap: () => _selectCampaign(i),
                                  child: AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    width: 72,
                                    height: 84,
                                    decoration: BoxDecoration(
                                      gradient: selected
                                          ? LinearGradient(
                                              colors: c.gradient,
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          : null,
                                      color: selected
                                          ? null
                                          : Theme.of(context)
                                              .colorScheme
                                              .surfaceContainerHighest,
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      border: selected
                                          ? null
                                          : Border.all(
                                              color: AppColors.divider,
                                              width: 1.5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(c.emoji,
                                            style: const TextStyle(
                                                fontSize: 24)),
                                        const SizedBox(height: 2),
                                        Text(
                                          c.label,
                                          style:
                                              AppTextStyles.caption.copyWith(
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
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            size: 14, color: AppColors.textHint),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ── Custom occasion label (only for Custom) ──────────
                    if (_selectedIndex == 5) ...[
                      Text('Occasion name',
                          style: AppTextStyles.labelMedium),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _customOccasionController,
                        maxLength: 40,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'e.g. Graduation, Ramadan, Work trip…',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // ── Message ──────────────────────────────────────────
                    Text('Your message',
                        style: AppTextStyles.labelMedium),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _msgController,
                      maxLines: 2,
                      maxLength: 120,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Write something heartfelt…',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
                        child: _CampaignCard(
                          campaign: _campaigns[_selectedIndex],
                          customLabel: _selectedIndex == 5
                              ? _customOccasionController.text.trim()
                              : null,
                          name: name,
                          avatarUrl: avatarUrl,
                          message: _msgController.text.trim().isNotEmpty
                              ? _msgController.text.trim()
                              : _campaigns[_selectedIndex].defaultMessage,
                          qrUrl: qrUrl,
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

// ── Shareable card widget ──────────────────────────────────────────────────

class _CampaignCard extends StatelessWidget {
  final _Campaign campaign;
  final String? customLabel;
  final String name;
  final String? avatarUrl;
  final String message;
  final String qrUrl;

  const _CampaignCard({
    required this.campaign,
    this.customLabel,
    required this.name,
    required this.avatarUrl,
    required this.message,
    required this.qrUrl,
  });

  @override
  Widget build(BuildContext context) {
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
          // ── Gradient banner ────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: campaign.gradient,
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
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.white, width: 3),
                        color: Colors.white24,
                      ),
                      child: ClipOval(
                        child: avatarUrl != null && avatarUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: avatarUrl!,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    _AvatarFallback(name: name),
                              )
                            : _AvatarFallback(name: name),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(campaign.emoji,
                            style: const TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (name.isNotEmpty)
                  Text(
                    name,
                    style: AppTextStyles.h2.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 6),
                // Show custom occasion label or default campaign label
                Text(
                  customLabel != null && customLabel!.isNotEmpty
                      ? '${campaign.emoji} $customLabel'
                      : '${campaign.emoji} ${campaign.label}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.80),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.92),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ── QR section ─────────────────────────────────────────────────
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
                    border:
                        Border.all(color: AppColors.divider, width: 1.5),
                  ),
                  child: QrImageView(
                    data: qrUrl,
                    version: QrVersions.auto,
                    size: 160,
                    backgroundColor: Colors.white,
                    eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: campaign.gradient.last,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: campaign.gradient.last,
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
                        gradient: LinearGradient(colors: campaign.gradient),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.monetization_on_rounded,
                          size: 12, color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'amTips',
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
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
