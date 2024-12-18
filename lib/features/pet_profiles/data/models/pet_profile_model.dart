import 'package:equatable/equatable.dart';

class PetProfile extends Equatable {
  final String id;
  final String name;
  final String breed;
  final int age;
  final String photoUrl;
  final String medicalHistory;
  final String gender; // Ensure gender is always a non-null String

  const PetProfile({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.photoUrl,
    required this.medicalHistory,
    required this.gender, // Add this field correctly
  });

  @override
  List<Object> get props => [id];

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'breed': breed,
      'age': age,
      'photoUrl': photoUrl,
      'medicalHistory': medicalHistory,
      'gender': gender,
    };
  }

  // Create from Map for Firestore
  static PetProfile fromMap(String id, Map<String, dynamic> map) {
    return PetProfile(
      id: id,
      name: map['name'] as String,
      breed: map['breed'] as String,
      age: map['age'] as int,
      photoUrl: map['photoUrl'] as String,
      medicalHistory: map['medicalHistory'] as String,
      gender: map['gender'] as String, // Ensure 'gender' is retrieved properly
    );
  }
}
