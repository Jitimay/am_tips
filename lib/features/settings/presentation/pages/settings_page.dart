import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../bloc/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.error != null) {
          SnackBarUtils.showError(context, state.error!);
        }
        if (state.successMessage != null) {
          SnackBarUtils.showSuccess(context, state.successMessage!);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView(
              children: [
                _SectionHeader('Appearance'),
                SwitchListTile.adaptive(
                  title: const Text('Dark mode'),
                  subtitle: const Text('Use dark theme'),
                  value: state.isDarkMode,
                  onChanged: (v) =>
                      context.read<SettingsCubit>().toggleDarkMode(v),
                  activeThumbColor: AppColors.primary,
                ),
                const Divider(height: 1),
                _SectionHeader('Notifications'),
                SwitchListTile.adaptive(
                  title: const Text('New tip alerts'),
                  subtitle: const Text('Notify when you receive a tip'),
                  value: state.tipNotifications,
                  onChanged: (v) {
                    context
                        .read<SettingsCubit>()
                        .setTipNotifications(v);
                    context
                        .read<SettingsCubit>()
                        .saveNotificationPreferences();
                  },
                  activeThumbColor: AppColors.primary,
                ),
                SwitchListTile.adaptive(
                  title: const Text('Withdrawal updates'),
                  subtitle: const Text('Notify on withdrawal status changes'),
                  value: state.withdrawalNotifications,
                  onChanged: (v) {
                    context
                        .read<SettingsCubit>()
                        .setWithdrawalNotifications(v);
                    context
                        .read<SettingsCubit>()
                        .saveNotificationPreferences();
                  },
                  activeThumbColor: AppColors.primary,
                ),
                const Divider(height: 1),
                _SectionHeader('Security'),
                ListTile(
                  leading: const Icon(Icons.lock_outline_rounded),
                  title: const Text('Change password'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showChangePasswordSheet(context),
                ),
                const Divider(height: 1),
                _SectionHeader('About'),
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text('Version'),
                  trailing: const Text('1.0.0',
                      style: TextStyle(color: AppColors.textSecondary)),
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy Policy'),
                  trailing:
                      const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showInfoDialog(
                    context,
                    'Privacy Policy',
                    'At amTips, your privacy is our top priority. We collect only necessary information to process digital tips and facilitate withdrawals to your payment account.\n\nWe never share your financial data with third parties without your explicit consent. All payment transmissions are encrypted using industry-standard protocols.\n\nFor questions about our data practices, reach out to support@amtips.app.',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.article_outlined),
                  title: const Text('Terms of Service'),
                  trailing:
                      const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showInfoDialog(
                    context,
                    'Terms of Service',
                    'By using amTips, you agree to comply with our service guidelines. amTips connects service workers with customers for voluntary digital gratuities.\n\nTips received belong directly to the recipient minus standard processing fees where applicable. Withdrawals are processed to verified mobile money and bank accounts according to regional provider availability.\n\nMisuse of the platform or fraudulent activity may result in account termination.',
                  ),
                ),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: AppTextStyles.h3),
        content: SingleChildScrollView(
          child: Text(
            content,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordSheet(BuildContext context) {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<SettingsCubit>(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Change Password', style: AppTextStyles.h3),
                const SizedBox(height: 20),
                AppTextField(
                  controller: currentCtrl,
                  label: 'Current password',
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: newCtrl,
                  label: 'New password',
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: confirmCtrl,
                  label: 'Confirm new password',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (v) =>
                      Validators.confirmPassword(v, newCtrl.text),
                ),
                const SizedBox(height: 24),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (ctx, state) => AppButton(
                    label: 'Update Password',
                    isLoading: state.isLoading,
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      ctx.read<SettingsCubit>().changePassword(
                            current: currentCtrl.text,
                            newPass: newCtrl.text,
                          );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
