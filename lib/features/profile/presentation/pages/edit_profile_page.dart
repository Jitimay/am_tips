import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/widgets/profession_picker.dart';
import '../../domain/entities/waiter_profile.dart';
import '../bloc/profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _restaurantController;
  late final TextEditingController _cityController;
  late final TextEditingController _countryController;
  late final TextEditingController _messageController;
  final TextEditingController _accountController = TextEditingController();

  String? _localAvatarPath;
  late Set<String> _selectedProfessions;

  // Payment account
  String _selectedProvider = 'Lumicash';
  bool _showPaymentForm = false;
  static const _providers = ['Lumicash', 'Ecocash', 'Bancobu', 'Other'];

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    final profile = state is ProfileLoaded ? state.profile : null;
    _nameController = TextEditingController(text: profile?.fullName);
    _restaurantController =
        TextEditingController(text: profile?.restaurantName);
    _cityController = TextEditingController(text: profile?.city);
    _countryController = TextEditingController(text: profile?.country);
    _messageController =
        TextEditingController(text: profile?.personalMessage);
    _selectedProfessions =
        Set<String>.from(profile?.professions ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _restaurantController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _messageController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 80, maxWidth: 512);
    if (image != null && mounted) {
      setState(() => _localAvatarPath = image.path);
      context.read<ProfileBloc>().add(ProfileAvatarUpdated(image.path));
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileBloc>().add(
          ProfileUpdated(
            fullName: _nameController.text.trim(),
            restaurantName: _restaurantController.text.trim(),
            city: _cityController.text.trim(),
            country: _countryController.text.trim(),
            personalMessage: _messageController.text.trim(),
            professions: _selectedProfessions.toList(),
          ),
        );
  }

  void _connectPaymentAccount() {
    final number = _accountController.text.trim();
    if (number.isEmpty) {
      SnackBarUtils.showError(context, 'Please enter your account number.');
      return;
    }
    context.read<ProfileBloc>().add(
          PaymentAccountConnected(
            type: 'mobile_money',
            provider: _selectedProvider,
            accountIdentifier: number,
          ),
        );
    setState(() {
      _showPaymentForm = false;
      _accountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          SnackBarUtils.showSuccess(context, 'Profile updated!');
          context.pop();
        } else if (state is ProfileError) {
          SnackBarUtils.showError(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final profile = state is ProfileLoaded
                ? state.profile
                : state is ProfileUpdating
                    ? state.profile
                    : null;
            final isLoading =
                state is ProfileUpdating || state is ProfileLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Avatar ──────────────────────────────────────
                    Center(
                      child: Stack(
                        children: [
                          AvatarWidget(
                            name: _nameController.text.isNotEmpty
                                ? _nameController.text
                                : 'You',
                            imageUrl: profile?.avatarUrl,
                            localFilePath: _localAvatarPath,
                            radius: 44,
                            onTap: _pickAvatar,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickAvatar,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(Icons.camera_alt_rounded,
                                    size: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Payment account (TOP — most important) ──────
                    _buildPaymentSection(profile?.connectedPaymentAccount),
                    const SizedBox(height: 24),

                    // ── Basic info ──────────────────────────────────
                    AppTextField(
                      controller: _nameController,
                      label: 'Full name',
                      validator: Validators.fullName,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(
                          Icons.person_outline_rounded,
                          size: 20),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _restaurantController,
                      label: 'Workplace / Venue (optional)',
                      hint: 'e.g. Restaurant, Club, Channel…',
                      textInputAction: TextInputAction.next,
                      prefixIcon:
                          const Icon(Icons.business_outlined, size: 20),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _cityController,
                            label: 'City',
                            validator: (v) =>
                                Validators.required(v, fieldName: 'City'),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            controller: _countryController,
                            label: 'Country',
                            validator: (v) =>
                                Validators.required(v, fieldName: 'Country'),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _messageController,
                      label: 'Personal message (optional)',
                      hint: 'Thank you for supporting my work ❤️',
                      maxLines: 3,
                      maxLength: 200,
                      validator: Validators.message,
                      textInputAction: TextInputAction.done,
                    ),

                    // ── Professions ─────────────────────────────────
                    const SizedBox(height: 24),
                    Text('What do you do?',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 12),
                    StatefulBuilder(
                      builder: (context, setLocal) => ProfessionPicker(
                        selected: _selectedProfessions,
                        onToggle: (label, _) => setLocal(() {
                          if (_selectedProfessions.contains(label)) {
                            _selectedProfessions.remove(label);
                          } else {
                            _selectedProfessions.add(label);
                          }
                        }),
                      ),
                    ),

                    // ── Save ────────────────────────────────────────
                    const SizedBox(height: 32),
                    AppButton(
                      label: 'Save Changes',
                      onPressed: _submit,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Payment account section ─────────────────────────────────────────────

  Widget _buildPaymentSection(PaymentAccountInfo? existing) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 18,
                    color: AppColors.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Withdrawal account',
                        style: AppTextStyles.labelMedium),
                    Text(
                      existing != null
                          ? '${existing.provider} · ${existing.accountIdentifier}'
                          : 'No account connected',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: existing != null
                            ? AppColors.accent
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Edit / Add button
              GestureDetector(
                onTap: () =>
                    setState(() => _showPaymentForm = !_showPaymentForm),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    existing != null
                        ? (_showPaymentForm ? 'Cancel' : 'Change')
                        : (_showPaymentForm ? 'Cancel' : 'Add'),
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),

          // Expandable form
          if (_showPaymentForm) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Text('Mobile money provider',
                style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _providers.map((p) {
                final selected = _selectedProvider == p;
                return GestureDetector(
                  onTap: () => setState(() => _selectedProvider = p),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : AppColors.cardBorder,
                      ),
                    ),
                    child: Text(
                      p,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: selected
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _accountController,
              label: 'Phone / account number',
              hint: '+257 XX XXX XXX',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              prefixIcon:
                  const Icon(Icons.phone_outlined, size: 20),
              onSubmitted: (_) => _connectPaymentAccount(),
            ),
            const SizedBox(height: 14),
            AppButton(
              label: existing != null
                  ? 'Update Account'
                  : 'Connect Account',
              onPressed: _connectPaymentAccount,
              prefixIcon: const Icon(Icons.check_rounded,
                  size: 18, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}
