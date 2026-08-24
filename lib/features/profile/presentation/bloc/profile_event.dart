part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

class ProfileUpdated extends ProfileEvent {
  final String? fullName;
  final String? restaurantName;
  final String? city;
  final String? country;
  final String? personalMessage;
  final List<String>? professions;

  const ProfileUpdated({
    this.fullName,
    this.restaurantName,
    this.city,
    this.country,
    this.personalMessage,
    this.professions,
  });

  @override
  List<Object?> get props =>
      [fullName, restaurantName, city, country, personalMessage, professions];
}

class ProfileAvatarUpdated extends ProfileEvent {
  final String filePath;
  const ProfileAvatarUpdated(this.filePath);
  @override
  List<Object?> get props => [filePath];
}

class PaymentAccountConnected extends ProfileEvent {
  final String type;
  final String provider;
  final String accountIdentifier;

  const PaymentAccountConnected({
    required this.type,
    required this.provider,
    required this.accountIdentifier,
  });

  @override
  List<Object?> get props => [type, provider, accountIdentifier];
}
