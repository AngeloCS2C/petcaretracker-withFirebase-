import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/core/errors/failure.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/repos/pet_profile_repo.dart';

class CreatePetProfile {
  final PetProfileRepository repository;

  CreatePetProfile({required this.repository});

  Future<Either<Failure, void>> call(PetProfile petProfile) {
    return repository.createPetProfile(petProfile);
  }
}
