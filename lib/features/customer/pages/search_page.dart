import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  bool _loading = false;
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search(String q) async {
    final trimmed = q.trim();
    if (trimmed == _query) return;
    _query = trimmed;

    if (trimmed.isEmpty) {
      setState(() => _results = []);
      return;
    }

    setState(() => _loading = true);
    try {
      // Use the public_profiles view + full-text search vector
      final data = await Supabase.instance.client
          .from('public_profiles')
          .select('id, full_name, avatar_url, restaurant_name, city, professions, average_rating, qr_token')
          .textSearch('search_vector', trimmed, config: 'simple')
          .eq('is_active', true)
          .limit(20);
      if (mounted) setState(() => _results = List<Map<String, dynamic>>.from(data));
    } catch (_) {
      // fallback: ilike on full_name
      try {
        final data = await Supabase.instance.client
            .from('public_profiles')
            .select('id, full_name, avatar_url, restaurant_name, city, professions, average_rating, qr_token')
            .ilike('full_name', '%$trimmed%')
            .eq('is_active', true)
            .limit(20);
        if (mounted) setState(() => _results = List<Map<String, dynamic>>.from(data));
      } catch (_) {
        if (mounted) setState(() => _results = []);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: _search,
          decoration: InputDecoration(
            hintText: 'Search by name, city, profession…',
            border: InputBorder.none,
            hintStyle: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textHint),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 18),
                    onPressed: () {
                      _controller.clear();
                      _search('');
                    },
                  )
                : null,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : _query.isEmpty
              ? _EmptyPrompt()
              : _results.isEmpty
                  ? _NoResults(query: _query)
                  : ListView.separated(
                      itemCount: _results.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, indent: 72, endIndent: 16),
                      itemBuilder: (_, i) =>
                          _ResultTile(profile: _results[i]),
                    ),
    );
  }
}

class _EmptyPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search_rounded, size: 56, color: AppColors.textHint),
          const SizedBox(height: 12),
          Text('Find someone to tip',
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text('Search by name, city or profession',
              style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  final String query;
  const _NoResults({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_search_rounded,
              size: 56, color: AppColors.textHint),
          const SizedBox(height: 12),
          Text('No results for "$query"',
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text('Try a different name or city',
              style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  final Map<String, dynamic> profile;
  const _ResultTile({required this.profile});

  @override
  Widget build(BuildContext context) {
    final name = profile['full_name'] as String? ?? '';
    final avatarUrl = profile['avatar_url'] as String?;
    final workplace = profile['restaurant_name'] as String? ?? '';
    final city = profile['city'] as String? ?? '';
    final rating = (profile['average_rating'] as num?)?.toDouble() ?? 0.0;
    final professions = (profile['professions'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final waiterId = profile['id'] as String;

    final subtitle = [
      if (professions.isNotEmpty) professions.first,
      if (workplace.isNotEmpty) workplace,
      if (city.isNotEmpty) city,
    ].join(' · ');

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: AppColors.primarySurface,
        backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
            ? CachedNetworkImageProvider(avatarUrl)
            : null,
        child: avatarUrl == null || avatarUrl.isEmpty
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: AppTextStyles.labelLarge
                    .copyWith(color: AppColors.primary),
              )
            : null,
      ),
      title: Text(name,
          style: AppTextStyles.labelMedium
              .copyWith(fontWeight: FontWeight.w600)),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle,
              style: AppTextStyles.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
          : null,
      trailing: rating > 0
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded,
                    size: 14, color: AppColors.star),
                const SizedBox(width: 2),
                Text(rating.toStringAsFixed(1),
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.textPrimary)),
              ],
            )
          : null,
      onTap: () => context.push('/t/$waiterId'),
    );
  }
}
