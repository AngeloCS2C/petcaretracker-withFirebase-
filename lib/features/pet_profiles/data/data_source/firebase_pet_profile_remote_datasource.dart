import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/pet_profile.dart';

class PetProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  PetProfileRemoteDataSource(this.firestore);

  // Add a new PetProfile
  Future<void> addPetProfile(PetProfile profile) async {
    try {
      await firestore
          .collection('pet_profiles')
          .doc(profile.id)
          .set(profile.toMap());
    } catch (e) {
      throw Exception('Error adding pet profile: $e');
    }
  }

  // Fetch all PetProfiles
  Future<List<PetProfile>> fetchAllPetProfiles() async {
    try {
      final querySnapshot = await firestore.collection('pet_profiles').get();
      if (querySnapshot.docs.isEmpty) {
        return []; // Return empty list if no profiles found
      }
      return querySnapshot.docs.map((doc) {
        return PetProfile.fromMap(doc.id, doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Error fetching pet profiles: $e');
    }
  }

  // Fetch a single PetProfile by ID
  Future<PetProfile> fetchPetProfileById(String id) async {
    try {
      final doc = await firestore.collection('pet_profiles').doc(id).get();
      if (!doc.exists) {
        throw Exception('Pet profile not found');
      }
      return PetProfile.fromMap(doc.id, doc.data()!);
    } catch (e) {
      throw Exception('Error fetching pet profile by ID: $e');
    }
  }

  // Update an existing PetProfile
  Future<void> updatePetProfile(String id, Map<String, dynamic> updates) async {
    try {
      await firestore.collection('pet_profiles').doc(id).update(updates);
    } catch (e) {
      throw Exception('Error updating pet profile: $e');
    }
  }

  // Delete a PetProfile
  Future<void> deletePetProfile(String id) async {
    try {
      await firestore.collection('pet_profiles').doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting pet profile: $e');
    }
  }
}
