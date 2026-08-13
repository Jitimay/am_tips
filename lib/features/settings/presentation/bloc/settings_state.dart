part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;
  final bool tipNotifications;
  final bool withdrawalNotifications;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const SettingsState({
    this.isDarkMode = false,
    this.tipNotifications = true,
    this.withdrawalNotifications = true,
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? tipNotifications,
    bool? withdrawalNotifications,
    bool? isLoading,
    String? error,
    String? successMessage,
  }) =>
      SettingsState(
        isDarkMode: isDarkMode ?? this.isDarkMode,
        tipNotifications: tipNotifications ?? this.tipNotifications,
        withdrawalNotifications:
            withdrawalNotifications ?? this.withdrawalNotifications,
        isLoading: isLoading ?? this.isLoading,
        error: error,
        successMessage: successMessage,
      );

  @override
  List<Object?> get props => [
        isDarkMode,
        tipNotifications,
        withdrawalNotifications,
        isLoading,
        error,
        successMessage,
      ];
}
