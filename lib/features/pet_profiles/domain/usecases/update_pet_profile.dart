import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/core/errors/failure.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/repos/pet_profile_repo.dart';

class UpdatePetProfile {
  final PetProfileRepository repository;

  UpdatePetProfile({required this.repository});

  Future<Either<Failure, void>> call(String id, PetProfile petProfile) {
    return repository.updatePetProfile(id, petProfile);
  }
}
