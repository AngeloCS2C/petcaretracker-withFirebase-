import '../../domain/entities/pet_profile.dart';

abstract class PetProfileRemoteDatasource{
  Future<void> createPetProfile(PetProfile petProfile);
  Future<List<PetProfile>> getAllPetProfiles();
  Future<PetProfile>getPetProfileById(String id);
  Future<void> updatePetProfile(PetProfile petProfile);
  Future< void> deletePetProfile(String id);
}
