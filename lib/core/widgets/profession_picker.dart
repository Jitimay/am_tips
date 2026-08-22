import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// All supported professions in amTips.
/// Restaurant/Waiter is one category among many — not the default.
const List<({String emoji, String name, String category})> kAllProfessions = [
  // ── Food & Hospitality ───────────────────────────────────────────────────
  (emoji: '🍽️', name: 'Waiter / Server',         category: 'Food & Hospitality'),
  (emoji: '👨‍🍳', name: 'Chef / Cook',              category: 'Food & Hospitality'),
  (emoji: '☕', name: 'Barista / Bartender',       category: 'Food & Hospitality'),
  (emoji: '🏨', name: 'Hotel Staff',               category: 'Food & Hospitality'),
  (emoji: '🛎️', name: 'Concierge / Receptionist', category: 'Food & Hospitality'),

  // ── Transport ────────────────────────────────────────────────────────────
  (emoji: '🚕', name: 'Taxi / Taky Driver',        category: 'Transport'),
  (emoji: '🏍️', name: 'Moto Taxi',                 category: 'Transport'),
  (emoji: '🚌', name: 'Bus Driver',                category: 'Transport'),
  (emoji: '🚢', name: 'Boat / Ferry Operator',     category: 'Transport'),

  // ── Music & Performing Arts ──────────────────────────────────────────────
  (emoji: '🎵', name: 'Musician / Singer',         category: 'Music & Arts'),
  (emoji: '🎭', name: 'Theater / Stage Artist',    category: 'Music & Arts'),
  (emoji: '💃', name: 'Dancer / Choreographer',    category: 'Music & Arts'),
  (emoji: '🎤', name: 'Stand-up Comedian',         category: 'Music & Arts'),
  (emoji: '🥁', name: 'Live Band / DJ',            category: 'Music & Arts'),
  (emoji: '🎻', name: 'Street Musician',           category: 'Music & Arts'),

  // ── Visual Arts ──────────────────────────────────────────────────────────
  (emoji: '🎨', name: 'Painter / Visual Artist',  category: 'Visual Arts'),
  (emoji: '📸', name: 'Photographer',              category: 'Visual Arts'),
  (emoji: '🖼️', name: 'Sculptor / Craftsman',     category: 'Visual Arts'),
  (emoji: '✍️', name: 'Calligrapher / Illustrator',category: 'Visual Arts'),
  (emoji: '🧵', name: 'Fashion Designer',          category: 'Visual Arts'),

  // ── Digital & Content Creation ───────────────────────────────────────────
  (emoji: '🎥', name: 'YouTuber / Video Creator', category: 'Digital & Content'),
  (emoji: '📱', name: 'Social Media Creator',      category: 'Digital & Content'),
  (emoji: '🎙️', name: 'Podcaster',                category: 'Digital & Content'),
  (emoji: '🎮', name: 'Streamer / Gamer',          category: 'Digital & Content'),
  (emoji: '🧑‍💻', name: 'Freelancer / Developer',  category: 'Digital & Content'),

  // ── Education & Coaching ─────────────────────────────────────────────────
  (emoji: '📚', name: 'Teacher / Tutor',           category: 'Education'),
  (emoji: '🏋️', name: 'Coach / Trainer',           category: 'Education'),
  (emoji: '🧘', name: 'Wellness / Yoga Teacher',   category: 'Education'),

  // ── Personal Services ────────────────────────────────────────────────────
  (emoji: '💇', name: 'Hairdresser / Barber',      category: 'Personal Services'),
  (emoji: '💅', name: 'Nail Technician',           category: 'Personal Services'),
  (emoji: '🧹', name: 'Cleaner / Housekeeper',     category: 'Personal Services'),
  (emoji: '👶', name: 'Babysitter / Nanny',        category: 'Personal Services'),
  (emoji: '🐾', name: 'Pet Care / Dog Walker',     category: 'Personal Services'),

  // ── Writing & Journalism ─────────────────────────────────────────────────
  (emoji: '📝', name: 'Writer / Author',           category: 'Writing'),
  (emoji: '📰', name: 'Journalist / Reporter',     category: 'Writing'),
  (emoji: '📖', name: 'Blogger / Reviewer',        category: 'Writing'),

  // ── Other ────────────────────────────────────────────────────────────────
  (emoji: '💼', name: 'Other',                     category: 'Other'),
];

/// Groups professions by category for section display.
Map<String, List<({String emoji, String name, String category})>>
    get kProfessionsByCategory {
  final map =
      <String, List<({String emoji, String name, String category})>>{};
  for (final p in kAllProfessions) {
    map.putIfAbsent(p.category, () => []).add(p);
  }
  return map;
}

/// Returns the display label for a profession (used as the stored value).
String professionLabel(String emoji, String name) => '$emoji $name';

/// Returns a short human-readable string from a list of stored profession labels.
/// e.g. ["🎵 Musician / Singer", "🎭 Theater / Stage Artist"] → "Musician, Theater Artist"
String formatProfessions(List<String> professions, {int max = 2}) {
  if (professions.isEmpty) return '';
  final shorts = professions.take(max).map((p) {
    // Strip emoji prefix
    final parts = p.split(' ');
    if (parts.length <= 1) return p;
    return parts.skip(1).join(' ').split(' / ').first;
  }).toList();
  final result = shorts.join(', ');
  if (professions.length > max) return '$result +${professions.length - max}';
  return result;
}

/// Scrollable profession picker with category sections.
/// Each profession is a toggleable chip. Multi-select allowed.
class ProfessionPicker extends StatelessWidget {
  final Set<String> selected;
  final void Function(String label, bool isOther) onToggle;
  final bool showCategories;

  const ProfessionPicker({
    super.key,
    required this.selected,
    required this.onToggle,
    this.showCategories = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showCategories) {
      return _flatGrid(context);
    }
    return _categorisedList(context);
  }

  Widget _categorisedList(BuildContext context) {
    final groups = kProfessionsByCategory;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groups.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 4),
              child: Text(
                entry.key,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                  fontSize: 11,
                ),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: entry.value.map((p) {
                final label = professionLabel(p.emoji, p.name);
                return _ProfessionChip(
                  emoji: p.emoji,
                  name: p.name,
                  label: label,
                  isSelected: selected.contains(label),
                  onTap: () => onToggle(label, p.name == 'Other'),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _flatGrid(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: kAllProfessions.map((p) {
        final label = professionLabel(p.emoji, p.name);
        return _ProfessionChip(
          emoji: p.emoji,
          name: p.name,
          label: label,
          isSelected: selected.contains(label),
          onTap: () => onToggle(label, p.name == 'Other'),
        );
      }).toList(),
    );
  }
}

class _ProfessionChip extends StatelessWidget {
  final String emoji;
  final String name;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProfessionChip({
    required this.emoji,
    required this.name,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                isSelected ? AppColors.primary : AppColors.cardBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              name,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textPrimary,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 12,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              Icon(Icons.check_circle_rounded,
                  size: 14, color: AppColors.primary),
            ],
          ],
        ),
      ),
    );
  }
}
