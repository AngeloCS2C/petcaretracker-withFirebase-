import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/repos/pet_profile_repo.dart';

import '../../../../core/errors/failure.dart';

class GetAllPetProfiles {
  final PetProfileRepository repository;

  GetAllPetProfiles({required this.repository});

  Future<Either<Failure, List<PetProfile>>> call() async =>
      repository.getAllPetProfiles();
}
