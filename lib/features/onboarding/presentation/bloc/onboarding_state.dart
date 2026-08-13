part of 'onboarding_cubit.dart';

enum OnboardingStep { personalInfo, serviceInfo, paymentAccount, qrCode }

class OnboardingState extends Equatable {
  final OnboardingStep step;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  // Collected data
  final String? fullName;
  final String? avatarPath;
  final String? restaurantName;
  final String? city;
  final String? country;
  final bool paymentConnected;
  final bool qrGenerated;

  const OnboardingState({
    this.step = OnboardingStep.personalInfo,
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.fullName,
    this.avatarPath,
    this.restaurantName,
    this.city,
    this.country,
    this.paymentConnected = false,
    this.qrGenerated = false,
  });

  OnboardingState copyWith({
    OnboardingStep? step,
    bool? isLoading,
    String? error,
    String? successMessage,
    String? fullName,
    String? avatarPath,
    String? restaurantName,
    String? city,
    String? country,
    bool? paymentConnected,
    bool? qrGenerated,
  }) {
    return OnboardingState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      successMessage: successMessage,
      fullName: fullName ?? this.fullName,
      avatarPath: avatarPath ?? this.avatarPath,
      restaurantName: restaurantName ?? this.restaurantName,
      city: city ?? this.city,
      country: country ?? this.country,
      paymentConnected: paymentConnected ?? this.paymentConnected,
      qrGenerated: qrGenerated ?? this.qrGenerated,
    );
  }

  int get stepIndex => OnboardingStep.values.indexOf(step);
  int get totalSteps => OnboardingStep.values.length;

  @override
  List<Object?> get props => [
        step,
        isLoading,
        error,
        successMessage,
        fullName,
        avatarPath,
        restaurantName,
        city,
        country,
        paymentConnected,
        qrGenerated,
      ];
}
