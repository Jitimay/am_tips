import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/avatar_widget.dart';
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
                    onPressed: () =>
                        context.read<OnboardingCubit>().goBack(),
                  )
                : null,
          ),
          body: Column(
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: (state.stepIndex + 1) / state.totalSteps,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
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
        return _PersonalInfoStep(key: const ValueKey('step1'));
      case OnboardingStep.serviceInfo:
        return _ServiceInfoStep(key: const ValueKey('step2'));
      case OnboardingStep.paymentAccount:
        return _PaymentAccountStep(key: const ValueKey('step3'));
      case OnboardingStep.qrCode:
        return _QrReadyStep(key: const ValueKey('step4'));
    }
  }
}

// ── Step 1: Personal Info ──────────────────────────────────────────────────

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
      if (mounted) {
        context.read<OnboardingCubit>().setAvatarPath(image.path);
      }
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
              'This is what customers will see on your tipping page.',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),

            // Avatar picker
            Center(
              child: Stack(
                children: [
                  AvatarWidget(
                    name: _nameController.text.isNotEmpty
                        ? _nameController.text
                        : 'You',
                    radius: 44,
                    imageUrl: _selectedAvatarPath != null ? null : null,
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

// ── Step 2: Service Info ───────────────────────────────────────────────────

class _ServiceInfoStep extends StatefulWidget {
  const _ServiceInfoStep({super.key});
  @override
  State<_ServiceInfoStep> createState() => _ServiceInfoStepState();
}

class _ServiceInfoStepState extends State<_ServiceInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _restaurantController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _restaurantController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<OnboardingCubit>().submitServiceInfo(
          restaurantName: _restaurantController.text.trim(),
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
            Text('Where do you work?', style: AppTextStyles.h2),
            const SizedBox(height: 6),
            Text(
              'Your restaurant will appear on your public tipping page.',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),

            AppTextField(
              controller: _restaurantController,
              label: 'Restaurant name',
              hint: 'e.g. Hotel Source du Nil',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.restaurant_outlined, size: 20),
              validator: Validators.restaurantName,
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _cityController,
              label: 'City',
              hint: 'e.g. Bujumbura',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.location_city_outlined, size: 20),
              validator: (v) => Validators.required(v, fieldName: 'City'),
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _countryController,
              label: 'Country',
              hint: 'e.g. Burundi',
              textInputAction: TextInputAction.done,
              prefixIcon: const Icon(Icons.flag_outlined, size: 20),
              validator: (v) => Validators.required(v, fieldName: 'Country'),
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

// ── Step 3: Payment Account ────────────────────────────────────────────────

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

            // Provider selection
            Text('Mobile money provider', style: AppTextStyles.labelMedium),
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
              prefixIcon: const Icon(Icons.phone_outlined, size: 20),
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

// ── Step 4: QR Ready ──────────────────────────────────────────────────────

class _QrReadyStep extends StatelessWidget {
  const _QrReadyStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success animation
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
          const Text('🎉 You\'re ready to\nreceive tips!',
              style: AppTextStyles.h1, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(
            'Your personal QR code has been generated.\nShare it with your customers and start receiving digital tips.',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
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
                  'amtips.app/t/${AppConstants.appName.toLowerCase()}',
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
              Future.delayed(
                const Duration(milliseconds: 100),
                () => context.go(AppRoutes.qr),
              );
            },
            variant: AppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}
