part of 'pet_profile_cubit.dart';

abstract class PetProfileState extends Equatable {
  const PetProfileState();

  @override
  List<Object> get props => [];
}

class PetProfileInitial extends PetProfileState {}

class PetProfileLoading extends PetProfileState {}

class PetProfileLoaded extends PetProfileState {
  final List<PetProfile> profiles;
  const PetProfileLoaded(this.profiles);

  @override
  List<Object> get props => [profiles];
}

class SinglePetProfileLoaded extends PetProfileState {
  final PetProfile profile;
  const SinglePetProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class PetProfileAdded extends PetProfileState {}

class PetProfileUpdated extends PetProfileState {}

class PetProfileDeleted extends PetProfileState {}

class PetProfileError extends PetProfileState {
  final String message;
  const PetProfileError(this.message);

  @override
  List<Object> get props => [message];
}
