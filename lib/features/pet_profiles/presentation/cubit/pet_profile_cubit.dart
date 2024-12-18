import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/repos/pet_profile_repo.dart';

part 'pet_profile_state.dart';

class PetProfileCubit extends Cubit<PetProfileState> {
  final PetProfileRepository repository;

  PetProfileCubit({required this.repository}) : super(PetProfileInitial());

  Future<void> fetchPetProfiles() async {
    emit(PetProfileLoading());
    final result = await repository.getAllPetProfiles();
    result.fold(
      (failure) => emit(PetProfileError(failure.message)),
      (profiles) => emit(PetProfileLoaded(profiles)),
    );
  }

  Future<void> createPetProfile(PetProfile profile) async {
    emit(PetProfileLoading());
    final result = await repository.createPetProfile(profile);
    result.fold(
      (failure) => emit(PetProfileError(failure.message)),
      (_) async {
        emit(PetProfileAdded());
        await fetchPetProfiles();
      },
    );
  }

  Future<void> updatePetProfile(String id, PetProfile profile) async {
    emit(PetProfileLoading());
    final result = await repository.updatePetProfile(id, profile);
    result.fold(
      (failure) => emit(PetProfileError(failure.message)),
      (_) async {
        emit(PetProfileUpdated());
        await fetchPetProfiles();
      },
    );
  }

  Future<void> deletePetProfile(String id) async {
    emit(PetProfileLoading());
    final result = await repository.deletePetProfile(id);
    result.fold(
      (failure) => emit(PetProfileError(failure.message)),
      (_) async {
        emit(PetProfileDeleted());
        await fetchPetProfiles();
      },
    );
  }

  Future<void> getPetProfileById(String id) async {
    emit(PetProfileLoading());
    final result = await repository.getPetProfileById(id);
    result.fold(
      (failure) => emit(PetProfileError(failure.message)),
      (profile) => emit(SinglePetProfileLoaded(profile)),
    );
  }
}
