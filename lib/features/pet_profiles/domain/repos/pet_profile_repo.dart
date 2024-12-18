import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/core/errors/failure.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';

abstract class PetProfileRepository {
  Future<Either<Failure, List<PetProfile>>> getAllPetProfiles();
  Future<Either<Failure, PetProfile>> getPetProfileById(String id);
  Future<Either<Failure, void>> createPetProfile(PetProfile profile);
  Future<Either<Failure, void>> updatePetProfile(String id, PetProfile profile);
  Future<Either<Failure, void>> deletePetProfile(String id);
}
