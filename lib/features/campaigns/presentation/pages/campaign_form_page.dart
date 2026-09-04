import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/campaign.dart';
import '../bloc/campaign_bloc.dart';
import '../bloc/campaign_event.dart';
import '../bloc/campaign_state.dart';

class CampaignFormPage extends StatefulWidget {
  /// Pass an existing campaign to edit; null to create.
  final Campaign? campaign;

  const CampaignFormPage({super.key, this.campaign});

  @override
  State<CampaignFormPage> createState() => _CampaignFormPageState();
}

class _CampaignFormPageState extends State<CampaignFormPage> {
  final _formKey = GlobalKey<FormState>();
  late CampaignCategory _category;
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _targetCtrl;
  DateTime? _endDate;
  bool get _isEditing => widget.campaign != null;

  @override
  void initState() {
    super.initState();
    final c = widget.campaign;
    _category = c?.category ?? CampaignCategory.other;
    _titleCtrl = TextEditingController(text: c?.title ?? _category.defaultTitle);
    _descCtrl = TextEditingController(text: c?.description ?? _category.defaultDescription);
    _targetCtrl = TextEditingController(
      text: c?.targetAmount != null ? c!.targetAmount.toString() : '',
    );
    _endDate = c?.endDate;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }

  void _onCategoryChanged(CampaignCategory cat) {
    setState(() {
      _category = cat;
      if (_titleCtrl.text.isEmpty || !_isEditing) {
        _titleCtrl.text = cat.defaultTitle;
      }
      if (_descCtrl.text.isEmpty || !_isEditing) {
        _descCtrl.text = cat.defaultDescription;
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final now = DateTime.now();
    final campaign = Campaign(
      id: widget.campaign?.id ?? const Uuid().v4(),
      waiterId: widget.campaign?.waiterId ?? '',
      title: _titleCtrl.text.trim(),
      category: _category,
      description: _descCtrl.text.trim(),
      emoji: _category.defaultEmoji,
      targetAmount: _targetCtrl.text.trim().isNotEmpty
          ? int.tryParse(_targetCtrl.text.trim())
          : null,
      currentAmount: widget.campaign?.currentAmount ?? 0,
      tipsCount: widget.campaign?.tipsCount ?? 0,
      isActive: widget.campaign?.isActive ?? true,
      startDate: widget.campaign?.startDate ?? now,
      endDate: _endDate,
      createdAt: widget.campaign?.createdAt ?? now,
      updatedAt: now,
    );

    if (_isEditing) {
      context.read<CampaignBloc>().add(UpdateCampaign(campaign));
    } else {
      context.read<CampaignBloc>().add(CreateCampaign(campaign));
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Campaign' : 'New Campaign'),
      ),
      body: BlocConsumer<CampaignBloc, CampaignState>(
        listener: (context, state) {
          if (state is CampaignSaved) {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.campaign);
            }
          }
          if (state is CampaignError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          final isSaving = state is CampaignSaving;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Category picker ────────────────────────────────────
                  Text('Occasion', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 10),
                  _OccasionPicker(
                    selected: _category,
                    onChanged: _onCategoryChanged,
                  ),

                  const SizedBox(height: 20),

                  // ── Title ──────────────────────────────────────────────
                  Text('Title', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleCtrl,
                    maxLength: 80,
                    decoration: _inputDecoration('e.g. My Birthday Tip Jar 🎂'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Title is required' : null,
                  ),

                  const SizedBox(height: 16),

                  // ── Description ────────────────────────────────────────
                  Text('Description', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descCtrl,
                    maxLines: 3,
                    maxLength: 200,
                    decoration: _inputDecoration('Tell your supporters what this is about…'),
                  ),

                  const SizedBox(height: 16),

                  // ── Target amount (optional) ───────────────────────────
                  Text('Goal Amount (optional)', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _targetCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _inputDecoration('e.g. 50000 BIF — leave blank for no goal'),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return null;
                      final n = int.tryParse(v.trim());
                      if (n == null || n <= 0) return 'Enter a valid amount';
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // ── End date (optional) ────────────────────────────────
                  Text('End Date (optional)', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickEndDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.divider),
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded,
                              size: 18, color: AppColors.textSecondary),
                          const SizedBox(width: 10),
                          Text(
                            _endDate != null
                                ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                                : 'No end date',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: _endDate != null
                                  ? AppColors.textPrimary
                                  : AppColors.textHint,
                            ),
                          ),
                          const Spacer(),
                          if (_endDate != null)
                            GestureDetector(
                              onTap: () => setState(() => _endDate = null),
                              child: const Icon(Icons.close_rounded,
                                  size: 18, color: AppColors.textSecondary),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  AppButton(
                    label: _isEditing ? 'Save Changes' : 'Create Campaign',
                    isLoading: isSaving,
                    onPressed: isSaving ? null : _submit,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Occasion picker — horizontal scrollable chips with → scroll hint
// ─────────────────────────────────────────────────────────────────────────────

class _OccasionPicker extends StatefulWidget {
  final CampaignCategory selected;
  final ValueChanged<CampaignCategory> onChanged;

  const _OccasionPicker({
    required this.selected,
    required this.onChanged,
  });

  @override
  State<_OccasionPicker> createState() => _OccasionPickerState();
}

class _OccasionPickerState extends State<_OccasionPicker> {
  final _scrollCtrl = ScrollController();
  bool _showRightArrow = true;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      final atEnd = _scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 8;
      if (atEnd != !_showRightArrow) {
        setState(() => _showRightArrow = !atEnd);
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = CampaignCategory.values;
    return Stack(
      children: [
        // ── Scrollable list ─────────────────────────────────────────────
        SizedBox(
          height: 96,
          child: ListView.separated(
            controller: _scrollCtrl,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 32), // space for arrow
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              final cat = categories[i];
              final selected = cat == widget.selected;
              return GestureDetector(
                onTap: () => widget.onChanged(cat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: selected
                        ? LinearGradient(
                            colors: cat.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: selected
                        ? null
                        : Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    border: selected
                        ? Border.all(
                            color: cat.gradientColors.last.withValues(alpha: 0.5),
                            width: 2,
                          )
                        : Border.all(color: AppColors.divider),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: cat.gradientColors.last
                                  .withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cat.defaultEmoji,
                        style: TextStyle(
                          fontSize: selected ? 28 : 24,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          cat.label.split(' ').first,
                          style: AppTextStyles.caption.copyWith(
                            color: selected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // ── Right-edge fade + arrow hint ─────────────────────────────────
        if (_showRightArrow)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                width: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
