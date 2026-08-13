import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsCubit({required this.settingsRepository})
      : super(const SettingsState());

  void toggleDarkMode(bool value) =>
      emit(state.copyWith(isDarkMode: value));

  void setTipNotifications(bool value) =>
      emit(state.copyWith(tipNotifications: value));

  void setWithdrawalNotifications(bool value) =>
      emit(state.copyWith(withdrawalNotifications: value));

  Future<void> changePassword({
    required String current,
    required String newPass,
  }) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    final result = await settingsRepository.changePassword(
      currentPassword: current,
      newPassword: newPass,
    );
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (_) => emit(state.copyWith(
          isLoading: false, successMessage: 'Password changed successfully.')),
    );
  }

  Future<void> saveNotificationPreferences() async {
    await settingsRepository.updateNotificationPreferences(
      tipReceived: state.tipNotifications,
      withdrawalUpdate: state.withdrawalNotifications,
    );
  }
}
