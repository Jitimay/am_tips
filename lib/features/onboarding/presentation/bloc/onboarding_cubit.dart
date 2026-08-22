import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
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
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(state.copyWith(
        isLoading: false,
        fullName: fullName,
        avatarPath: avatarPath,
        step: OnboardingStep.professions,
      )),
    );
  }

  // ── Step 2 — Professions ──────────────────────────────────────────────────

  Future<void> submitProfessions(List<String> professions) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await profileRepository.completeOnboardingProfessions(
      professions: professions,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(state.copyWith(
        isLoading: false,
        professions: professions,
        step: OnboardingStep.locationInfo,
      )),
    );
  }

  // ── Step 3 — Location + Workplace ─────────────────────────────────────────
  // restaurantName is now a generic "workplace / venue" — optional.

  Future<void> submitLocationInfo({
    required String city,
    required String country,
    String? workplaceName,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await profileRepository.completeOnboardingStep2(
      restaurantName: workplaceName ?? '',
      city: city,
      country: country,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(state.copyWith(
        isLoading: false,
        restaurantName: workplaceName,
        city: city,
        country: country,
        step: OnboardingStep.paymentAccount,
      )),
    );
  }

  // ── Step 4 — Payment Account ──────────────────────────────────────────────

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
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
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

  // ── Step 5 — QR Ready ────────────────────────────────────────────────────

  Future<void> markQrReady() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.onboardingCompleteKey, true);
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
