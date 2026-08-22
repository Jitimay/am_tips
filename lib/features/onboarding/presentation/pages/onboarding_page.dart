import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/widgets/profession_picker.dart';
import '../bloc/onboarding_cubit.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.error != null) {
          SnackBarUtils.showError(context, state.error!);
        }
        if (state.qrGenerated) {
          context.go(AppRoutes.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text('Step ${state.stepIndex + 1} of ${state.totalSteps}'),
            leading: state.stepIndex > 0
                ? BackButton(
                    onPressed: () => context.read<OnboardingCubit>().goBack(),
                  )
                : null,
          ),
          body: Column(
            children: [
              LinearProgressIndicator(
                value: (state.stepIndex + 1) / state.totalSteps,
                backgroundColor: AppColors.divider,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 3,
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStep(context, state),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStep(BuildContext context, OnboardingState state) {
    switch (state.step) {
      case OnboardingStep.personalInfo:
        return const _PersonalInfoStep(key: ValueKey('step1'));
      case OnboardingStep.professions:
        return const _ProfessionsStep(key: ValueKey('step2'));
      case OnboardingStep.locationInfo:
        return const _LocationInfoStep(key: ValueKey('step3'));
      case OnboardingStep.paymentAccount:
        return const _PaymentAccountStep(key: ValueKey('step4'));
      case OnboardingStep.qrCode:
        return const _QrReadyStep(key: ValueKey('step5'));
    }
  }
}

// ── Step 1: Personal Info ─────────────────────────────────────────────────

class _PersonalInfoStep extends StatefulWidget {
  const _PersonalInfoStep({super.key});

  @override
  State<_PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<_PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _selectedAvatarPath;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 512,
    );
    if (image != null) {
      setState(() => _selectedAvatarPath = image.path);
      if (mounted) context.read<OnboardingCubit>().setAvatarPath(image.path);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<OnboardingCubit>().submitPersonalInfo(
          fullName: _nameController.text.trim(),
          avatarPath: _selectedAvatarPath,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Personal information', style: AppTextStyles.h2),
            const SizedBox(height: 6),
            Text(
              'This is what people will see on your tipping page.',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            Center(
              child: Stack(
                children: [
                  AvatarWidget(
                    name: _nameController.text.isNotEmpty
                        ? _nameController.text
                        : 'You',
                    radius: 44,
                    localFilePath: _selectedAvatarPath,
                    onTap: _pickImage,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt_rounded,
                            size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: _pickImage,
                child: const Text('Upload photo'),
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _nameController,
              label: 'Full name',
              hint: 'Joshua Ndayishimiye',
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
              validator: Validators.fullName,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 32),
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) => AppButton(
                label: 'Continue',
                onPressed: _submit,
                isLoading: state.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step 2: Professions ───────────────────────────────────────────────────
// Moved before location so the platform understands the person first.

class _ProfessionsStep extends StatefulWidget {
  const _ProfessionsStep({super.key});

  @override
  State<_ProfessionsStep> createState() => _ProfessionsStepState();
}

class _ProfessionsStepState extends State<_ProfessionsStep> {
  final Set<String> _selected = {};
  final _otherController = TextEditingController();
  bool _showOther = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill from cubit state in case user went back
    final existing = context.read<OnboardingCubit>().state.professions;
    _selected.addAll(existing);
    _showOther = _selected.any((s) => s.contains('Other'));
  }

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  void _toggle(String label, bool isOther) {
    setState(() {
      if (_selected.contains(label)) {
        _selected.remove(label);
      } else {
        _selected.add(label);
      }
      if (isOther) _showOther = _selected.contains(label);
    });
  }

  void _submit() {
    final list = _selected.where((s) => !s.contains('💼 Other')).toList();
    if (_showOther && _otherController.text.trim().isNotEmpty) {
      list.add(_otherController.text.trim());
    }
    if (list.isEmpty) {
      SnackBarUtils.showError(
          context, 'Please select at least one profession.');
      return;
    }
    context.read<OnboardingCubit>().submitProfessions(list);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text('What do you do?', style: AppTextStyles.h2),
          const SizedBox(height: 6),
          Text(
            'Select everything that applies — customers will see this on your tip page.',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          // Hint banner
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline_rounded,
                    color: AppColors.primary, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'amTips works for waiters, musicians, taxi drivers, artists and more — you\'re not limited to one category.',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ProfessionPicker(
            selected: _selected,
            onToggle: _toggle,
            showCategories: true,
          ),
          if (_showOther) ...[
            const SizedBox(height: 12),
            AppTextField(
              controller: _otherController,
              label: 'Describe your work',
              hint: 'e.g. Street performer, acrobat…',
              textInputAction: TextInputAction.done,
              prefixIcon:
                  const Icon(Icons.edit_outlined, size: 20),
            ),
          ],
          const SizedBox(height: 32),
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) => Column(
              children: [
                AppButton(
                  label: 'Continue',
                  onPressed: _submit,
                  isLoading: state.isLoading,
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Skip for now',
                  onPressed: state.isLoading
                      ? null
                      : () => context
                          .read<OnboardingCubit>()
                          .submitProfessions([]),
                  variant: AppButtonVariant.ghost,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Step 3: Location & Workplace ─────────────────────────────────────────
// City + country are required. Workplace/venue is optional context.

class _LocationInfoStep extends StatefulWidget {
  const _LocationInfoStep({super.key});

  @override
  State<_LocationInfoStep> createState() => _LocationInfoStepState();
}

class _LocationInfoStepState extends State<_LocationInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _workplaceController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<OnboardingCubit>().state;
    _workplaceController.text = state.restaurantName ?? '';
    _cityController.text = state.city ?? '';
    _countryController.text = state.country ?? '';
  }

  @override
  void dispose() {
    _workplaceController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  /// Returns the placeholder for the workplace field based on selected professions.
  String get _workplaceHint {
    final profs =
        context.read<OnboardingCubit>().state.professions;
    if (profs.any((p) =>
        p.contains('Waiter') ||
        p.contains('Chef') ||
        p.contains('Barista') ||
        p.contains('Hotel'))) {
      return 'e.g. Restaurant Le Chalet, Hotel Source du Nil';
    }
    if (profs.any((p) =>
        p.contains('Taxi') ||
        p.contains('Moto') ||
        p.contains('Driver'))) {
      return 'e.g. Taxi Bujumbura, Independent';
    }
    if (profs.any((p) =>
        p.contains('Musician') ||
        p.contains('Theater') ||
        p.contains('Dancer') ||
        p.contains('Band'))) {
      return 'e.g. Club La Palmeraie, Théâtre de Bujumbura';
    }
    if (profs.any((p) =>
        p.contains('YouTuber') ||
        p.contains('Podcaster') ||
        p.contains('Streamer') ||
        p.contains('Content'))) {
      return 'e.g. my YouTube channel, independent';
    }
    return 'e.g. your venue or employer (optional)';
  }

  String get _workplaceLabel {
    final profs =
        context.read<OnboardingCubit>().state.professions;
    if (profs.any((p) =>
        p.contains('Waiter') ||
        p.contains('Chef') ||
        p.contains('Barista') ||
        p.contains('Hotel'))) {
      return 'Restaurant / Venue name';
    }
    if (profs.any((p) =>
        p.contains('Musician') ||
        p.contains('Theater') ||
        p.contains('Dancer'))) {
      return 'Club / Stage / Venue';
    }
    if (profs.any((p) =>
        p.contains('YouTuber') ||
        p.contains('Streamer') ||
        p.contains('Content'))) {
      return 'Channel / Platform name';
    }
    return 'Workplace / Venue (optional)';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<OnboardingCubit>().submitLocationInfo(
          workplaceName: _workplaceController.text.trim(),
          city: _cityController.text.trim(),
          country: _countryController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Where are you based?', style: AppTextStyles.h2),
            const SizedBox(height: 6),
            Text(
              'Your city will appear on your tipping page. Workplace is optional.',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            AppTextField(
              controller: _cityController,
              label: 'City',
              hint: 'e.g. Bujumbura',
              textInputAction: TextInputAction.next,
              prefixIcon:
                  const Icon(Icons.location_city_outlined, size: 20),
              validator: (v) =>
                  Validators.required(v, fieldName: 'City'),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _countryController,
              label: 'Country',
              hint: 'e.g. Burundi',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.flag_outlined, size: 20),
              validator: (v) =>
                  Validators.required(v, fieldName: 'Country'),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _workplaceController,
              label: _workplaceLabel,
              hint: _workplaceHint,
              textInputAction: TextInputAction.done,
              prefixIcon:
                  const Icon(Icons.business_outlined, size: 20),
              // No validator — this field is optional
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 8),
            Text(
              'Customers see this for context — it does not change your tip setup.',
              style: AppTextStyles.caption
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) => AppButton(
                label: 'Continue',
                onPressed: _submit,
                isLoading: state.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step 4: Payment Account ───────────────────────────────────────────────

class _PaymentAccountStep extends StatefulWidget {
  const _PaymentAccountStep({super.key});

  @override
  State<_PaymentAccountStep> createState() => _PaymentAccountStepState();
}

class _PaymentAccountStepState extends State<_PaymentAccountStep> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  String _selectedProvider = 'Lumicash';
  static const _providers = ['Lumicash', 'Ecocash', 'Bancobu', 'Other'];

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<OnboardingCubit>().connectPaymentAccount(
          type: 'mobile_money',
          provider: _selectedProvider,
          accountIdentifier: _accountController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Connect payment account', style: AppTextStyles.h2),
            const SizedBox(height: 6),
            Text(
              'This is where your tips will be sent when you withdraw.',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            Text('Mobile money provider',
                style: AppTextStyles.labelMedium),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _providers
                  .map(
                    (p) => ChoiceChip(
                      label: Text(p),
                      selected: _selectedProvider == p,
                      onSelected: (_) =>
                          setState(() => _selectedProvider = p),
                      selectedColor:
                          AppColors.primary.withValues(alpha: 0.15),
                      labelStyle: AppTextStyles.labelSmall.copyWith(
                        color: _selectedProvider == p
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: _selectedProvider == p
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _accountController,
              label: 'Phone / account number',
              hint: '+257 XX XXX XXX',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              prefixIcon:
                  const Icon(Icons.phone_outlined, size: 20),
              validator: Validators.phone,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 32),
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) => Column(
                children: [
                  AppButton(
                    label: 'Connect Account',
                    onPressed: _submit,
                    isLoading: state.isLoading,
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Skip for now',
                    onPressed: state.isLoading
                        ? null
                        : () => context
                            .read<OnboardingCubit>()
                            .skipPaymentAccount(),
                    variant: AppButtonVariant.ghost,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step 5: QR Ready ─────────────────────────────────────────────────────

class _QrReadyStep extends StatelessWidget {
  const _QrReadyStep({super.key});

  @override
  Widget build(BuildContext context) {
    final profs =
        context.read<OnboardingCubit>().state.professions;
    final profLine = profs.isNotEmpty
        ? profs
            .take(2)
            .map((p) => p.split(' ').skip(1).join(' ').split(' / ').first)
            .join(' & ')
        : 'your work';

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: AppColors.tipGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.3),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.qr_code_rounded,
                size: 56, color: Colors.white),
          ),
          const SizedBox(height: 28),
          const Text(
            '🎉 You\'re ready to\nreceive tips!',
            style: AppTextStyles.h1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Your personal QR code is ready. Anyone can scan it to tip you for $profLine.',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.accent, size: 20),
                const SizedBox(width: 8),
                Text(
                  'amtips.app/t/…',
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.accent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          AppButton(
            label: 'View My Dashboard',
            onPressed: () =>
                context.read<OnboardingCubit>().markQrReady(),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'View My QR Code',
            onPressed: () {
              context.read<OnboardingCubit>().markQrReady();
              context.go(AppRoutes.qr);
            },
            variant: AppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}
