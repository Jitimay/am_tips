part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  WaiterProfile? get profile => null;
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  @override
  final WaiterProfile profile;
  const ProfileLoaded({required this.profile});
  @override
  List<Object?> get props => [profile];
}

class ProfileUpdating extends ProfileState {
  @override
  final WaiterProfile profile;
  const ProfileUpdating({required this.profile});
  @override
  List<Object?> get props => [profile];
}

class ProfileUpdateSuccess extends ProfileState {
  @override
  final WaiterProfile profile;
  const ProfileUpdateSuccess({required this.profile});
  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}
