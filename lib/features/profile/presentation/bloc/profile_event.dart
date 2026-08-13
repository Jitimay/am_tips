part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileEvent {
  const ProfileLoaded();
}

class ProfileUpdated extends ProfileEvent {
  final String? fullName;
  final String? restaurantName;
  final String? city;
  final String? country;
  final String? personalMessage;

  const ProfileUpdated({
    this.fullName,
    this.restaurantName,
    this.city,
    this.country,
    this.personalMessage,
  });

  @override
  List<Object?> get props =>
      [fullName, restaurantName, city, country, personalMessage];
}

class ProfileAvatarUpdated extends ProfileEvent {
  final String filePath;
  const ProfileAvatarUpdated(this.filePath);
  @override
  List<Object?> get props => [filePath];
}
