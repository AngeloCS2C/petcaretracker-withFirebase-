import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/core/errors/failure.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/repos/pet_profile_repo.dart';

import '../data_source/firebase_pet_profile_remote_datasource.dart';

class PetProfileRepositoryImpl implements PetProfileRepository {
  final PetProfileRemoteDataSource remoteDataSource;

  PetProfileRepositoryImpl(FirebaseFirestore firestore,
      {required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PetProfile>>> getAllPetProfiles() async {
    try {
      final petProfiles = await remoteDataSource.fetchAllPetProfiles();
      return Right(petProfiles);
    } catch (error) {
      return Left(Failure(message: 'Failed to fetch pet profiles: $error'));
    }
  }

  @override
  Future<Either<Failure, PetProfile>> getPetProfileById(String id) async {
    try {
      final petProfile = await remoteDataSource.fetchPetProfileById(id);
      return Right(petProfile);
    } catch (error) {
      return Left(
          Failure(message: 'Failed to fetch pet profile by ID: $error'));
    }
  }

  @override
  Future<Either<Failure, void>> createPetProfile(PetProfile profile) async {
    try {
      await remoteDataSource.addPetProfile(profile);
      return const Right(null);
    } catch (error) {
      return Left(Failure(message: 'Failed to create pet profile: $error'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePetProfile(
      String id, PetProfile profile) async {
    try {
      await remoteDataSource.updatePetProfile(id, profile.toMap());
      return const Right(null);
    } catch (error) {
      return Left(Failure(message: 'Failed to update pet profile: $error'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePetProfile(String id) async {
    try {
      await remoteDataSource.deletePetProfile(id);
      return const Right(null);
    } catch (error) {
      return Left(Failure(message: 'Failed to delete pet profile: $error'));
    }
  }
}
