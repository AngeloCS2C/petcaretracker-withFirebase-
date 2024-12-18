import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/repos/pet_profile_repo.dart';

import '../../../../core/errors/failure.dart';

class DeletePetProfile {
  final PetProfileRepository repository;

  DeletePetProfile({required this.repository});

  Future<Either<Failure, void>> call(String id) {
    return repository.deletePetProfile(id);
  }
}
