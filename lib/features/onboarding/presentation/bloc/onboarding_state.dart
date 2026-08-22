part of 'onboarding_cubit.dart';

// New step order: personalInfo → professions → locationInfo → paymentAccount → qrCode
enum OnboardingStep {
  personalInfo,
  professions,
  locationInfo,
  paymentAccount,
  qrCode,
}

class OnboardingState extends Equatable {
  final OnboardingStep step;
  final bool isLoading;
  final String? error;

  // Collected data
  final String? fullName;
  final String? avatarPath;
  final List<String> professions;
  final String? restaurantName; // kept as "workplace name" — generic
  final String? city;
  final String? country;
  final bool paymentConnected;
  final bool qrGenerated;

  const OnboardingState({
    this.step = OnboardingStep.personalInfo,
    this.isLoading = false,
    this.error,
    this.fullName,
    this.avatarPath,
    this.professions = const [],
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
    String? fullName,
    String? avatarPath,
    List<String>? professions,
    String? restaurantName,
    String? city,
    String? country,
    bool? paymentConnected,
    bool? qrGenerated,
  }) {
    return OnboardingState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      error: error, // intentionally not ?? — null clears the error
      fullName: fullName ?? this.fullName,
      avatarPath: avatarPath ?? this.avatarPath,
      professions: professions ?? this.professions,
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
        fullName,
        avatarPath,
        professions,
        restaurantName,
        city,
        country,
        paymentConnected,
        qrGenerated,
      ];
}
