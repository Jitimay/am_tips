import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/waiter_profile.dart';
import '../../domain/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository})
      : super(const ProfileInitial()) {
    on<LoadProfile>(_onLoaded);
    on<ProfileUpdated>(_onUpdated);
    on<ProfileAvatarUpdated>(_onAvatarUpdated);
  }

  Future<void> _onLoaded(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    final result = await profileRepository.getProfile();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> _onUpdated(
      ProfileUpdated event, Emitter<ProfileState> emit) async {
    final current =
        state is ProfileLoaded ? (state as ProfileLoaded).profile : null;
    if (current != null) emit(ProfileUpdating(profile: current));

    final result = await profileRepository.updateProfile(
      fullName: event.fullName,
      restaurantName: event.restaurantName,
      city: event.city,
      country: event.country,
      personalMessage: event.personalMessage,
      professions: event.professions,
    );
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileUpdateSuccess(profile: profile)),
    );
  }

  Future<void> _onAvatarUpdated(
      ProfileAvatarUpdated event, Emitter<ProfileState> emit) async {
    final current =
        state is ProfileLoaded ? (state as ProfileLoaded).profile : null;
    if (current != null) emit(ProfileUpdating(profile: current));

    final result = await profileRepository.uploadAvatar(event.filePath);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => add(const LoadProfile()),
    );
  }
}
