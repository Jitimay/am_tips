import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/domain/repositories/profile_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final ProfileRepository profileRepository;

  OnboardingCubit({required this.profileRepository})
      : super(const OnboardingState());

  // ── Step 1 — Personal Info ────────────────────────────────────────────────

  void setAvatarPath(String path) {
    emit(state.copyWith(avatarPath: path));
  }

  Future<void> submitPersonalInfo({
    required String fullName,
    String? avatarPath,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await profileRepository.completeOnboardingStep1(
      fullName: fullName,
      avatarPath: avatarPath,
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(state.copyWith(
        isLoading: false,
        fullName: fullName,
        avatarPath: avatarPath,
        step: OnboardingStep.serviceInfo,
      )),
    );
  }

  // ── Step 2 — Service Info ─────────────────────────────────────────────────

  Future<void> submitServiceInfo({
    required String restaurantName,
    required String city,
    required String country,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await profileRepository.completeOnboardingStep2(
      restaurantName: restaurantName,
      city: city,
      country: country,
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(state.copyWith(
        isLoading: false,
        restaurantName: restaurantName,
        city: city,
        country: country,
        step: OnboardingStep.paymentAccount,
      )),
    );
  }

  // ── Step 3 — Payment Account ──────────────────────────────────────────────

  Future<void> connectPaymentAccount({
    required String type,
    required String provider,
    required String accountIdentifier,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await profileRepository.connectPaymentAccount(
      type: type,
      provider: provider,
      accountIdentifier: accountIdentifier,
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(state.copyWith(
        isLoading: false,
        paymentConnected: true,
        step: OnboardingStep.qrCode,
      )),
    );
  }

  void skipPaymentAccount() {
    emit(state.copyWith(step: OnboardingStep.qrCode));
  }

  // ── Step 4 — QR Ready ────────────────────────────────────────────────────

  void markQrReady() {
    emit(state.copyWith(qrGenerated: true));
  }

  // ── Navigation ────────────────────────────────────────────────────────────

  void goBack() {
    final idx = state.stepIndex;
    if (idx > 0) {
      emit(state.copyWith(
        step: OnboardingStep.values[idx - 1],
        error: null,
      ));
    }
  }
}
