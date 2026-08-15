import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Circular avatar that shows a network image or initials fallback.
class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double radius;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 24,
    this.backgroundColor,
    this.onTap,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final Widget avatar = CircleAvatar(
      radius: radius,
      backgroundColor:
          backgroundColor ?? AppColors.primary.withValues(alpha: 0.12),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => _initialsWidget(),
                placeholder: (context, url) => _initialsWidget(),
              ),
            )
          : _initialsWidget(),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }
    return avatar;
  }

  Widget _initialsWidget() {
    return Text(
      _initials,
      style: AppTextStyles.labelMedium.copyWith(
        color: AppColors.primary,
        fontSize: radius * 0.65,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
