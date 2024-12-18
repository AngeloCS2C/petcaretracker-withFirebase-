import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/core/errors/failure.dart';
import 'package:pet_care_tracker/features/pet_profiles/data/data_source/firebase_pet_profile_remote_datasource.dart';
import 'package:pet_care_tracker/features/pet_profiles/data/repository_impl/pet_profile_repo_impl.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';

class MockPetProfileRemoteDataSource extends Mock
    implements PetProfileRemoteDataSource {
  @override
  fetchAllPetProfiles() {}

  @override
  addPetProfile(PetProfile testPetProfile) {}
}

void main() {
  late PetProfileRepositoryImpl repository;
  late MockPetProfileRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockPetProfileRemoteDataSource();
    repository =
        PetProfileRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final testPetProfile = PetProfile(
    id: '1',
    name: 'Buddy',
    breed: 'Golden Retriever',
    age: 3,
    gender: 'Male',
    photoUrl: 'https://example.com/photo.jpg',
    medicalHistory: '',
  );

  final testPetProfileList = [testPetProfile];

  group('getAllPetProfiles', () {
    test('should return List of PetProfiles when successful', () async {
      // Arrange
      when(() => mockRemoteDataSource.fetchAllPetProfiles())
          .thenAnswer((_) async => testPetProfileList);

      // Act
      final result = await repository.getAllPetProfiles();

      // Assert
      expect(result, Right(testPetProfileList));
      verify(() => mockRemoteDataSource.fetchAllPetProfiles()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Failure when fetching PetProfiles fails', () async {
      // Arrange
      when(() => mockRemoteDataSource.fetchAllPetProfiles())
          .thenThrow(Exception('Server error'));

      // Act
      final result = await repository.getAllPetProfiles();

      // Assert
      expect(result, isA<Left<Failure, List<PetProfile>>>());
      verify(() => mockRemoteDataSource.fetchAllPetProfiles()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('createPetProfile', () {
    test('should return void when created successfully', () async {
      // Arrange
      when(() => mockRemoteDataSource.addPetProfile(testPetProfile))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.createPetProfile(testPetProfile);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockRemoteDataSource.addPetProfile(testPetProfile))
          .called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Failure when creation fails', () async {
      // Arrange
      when(() => mockRemoteDataSource.addPetProfile(testPetProfile))
          .thenThrow(Exception('Creation error'));

      // Act
      final result = await repository.createPetProfile(testPetProfile);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockRemoteDataSource.addPetProfile(testPetProfile))
          .called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
