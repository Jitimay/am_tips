import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/app_button.dart';
import '../bloc/auth_bloc.dart';

class VerifyEmailPage extends StatefulWidget {
  final String? email;

  const VerifyEmailPage({super.key, this.email});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  int _resendCooldown = 0;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _resendCooldown = 30);
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown > 1) {
        setState(() => _resendCooldown--);
      } else {
        timer.cancel();
        setState(() => _resendCooldown = 0);
      }
    });
  }

  void _onResend() {
    if (_resendCooldown > 0) return;
    context.read<AuthBloc>().add(const SendEmailVerificationRequested());
    _startCooldown();
  }

  void _onCheckStatus(String email) {
    context.read<AuthBloc>().add(CheckEmailVerificationStatus(email: email));
  }

  void _onBackToLogin() {
    context.read<AuthBloc>().add(const LogoutRequested());
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          SnackBarUtils.showSuccess(context, 'Email verified successfully!');
          if (state.user.isOnboardingComplete) {
            context.go(AppRoutes.home);
          } else {
            context.go(AppRoutes.onboarding);
          }
        } else if (state is RegisterPendingConfirmation &&
            state.message != null) {
          if (state.isResent) {
            SnackBarUtils.showSuccess(context, state.message!);
          } else {
            SnackBarUtils.showInfo(context, state.message!);
          }
        } else if (state is AuthFailure) {
          SnackBarUtils.showError(context, state.message);
        }
      },
      builder: (context, state) {
        final email = widget.email ??
            (state is RegisterPendingConfirmation ? state.email : '');

        final isChecking =
            state is RegisterPendingConfirmation && state.isChecking;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Verify Email'),
            leading: BackButton(onPressed: _onBackToLogin),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // Mail icon badge
                  Center(
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mark_email_unread_rounded,
                        size: 44,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Verify your email',
                    style: AppTextStyles.h1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We sent a verification link to:',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (email.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        email,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Tap the link in your email to activate your account. Once verified, tap below to continue.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),

                  // "I've Verified My Email" button
                  AppButton(
                    label: "I've Verified My Email",
                    onPressed: isChecking ? null : () => _onCheckStatus(email),
                    isLoading: isChecking,
                    prefixIcon: const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Resend verification email button
                  AppButton(
                    label: _resendCooldown > 0
                        ? 'Resend Email in ${_resendCooldown}s'
                        : 'Resend Verification Email',
                    onPressed: _resendCooldown > 0 ? null : _onResend,
                    variant: AppButtonVariant.outline,
                    prefixIcon: const Icon(
                      Icons.refresh_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Back to Login button
                  AppButton(
                    label: 'Back to Login',
                    onPressed: _onBackToLogin,
                    variant: AppButtonVariant.ghost,
                  ),
                  const SizedBox(height: 24),

                  // Helper note
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: AppColors.info,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Didn't receive the email? Check your spam/junk folder or request a new verification link.",
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
