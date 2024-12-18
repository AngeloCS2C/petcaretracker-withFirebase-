import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/repos/pet_profile_repo.dart';

import '../../../../core/errors/failure.dart';

class GetPetProfileById {
  final PetProfileRepository repository;

  GetPetProfileById({required this.repository});

  Future<Either<Failure, PetProfile>> call(String id) {
    return repository.getPetProfileById(id);
  }
}
