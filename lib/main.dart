// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_tracker/features/pet_profiles/data/data_source/firebase_pet_profile_remote_datasource.dart';

import 'firebase_options.dart';

// Import your repository and cubit classes:
import 'features/pet_profiles/data/repository_impl/pet_profile_repo_impl.dart';
import 'features/pet_profiles/presentation/cubit/pet_profile_cubit.dart';

import 'features/expense_category/data/repository_impl/expense_category_repo_impl.dart';
import 'features/expense_category/presentation/cubit/expense_category_cubit.dart';

// Import the main screen and pages you created:
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;
  await addMockDataToFirestore(firestore);
  await fetchPetProfiles(firestore);

  // Create instances of repositories
  final petProfileRepository = PetProfileRepositoryImpl(firestore,
      remoteDataSource: PetProfileRemoteDataSource(firestore));
  final expenseCategoryRepository = ExpenseCategoryRepositoryImpl(firestore);

  runApp(MyApp(
    petProfileRepository: petProfileRepository,
    expenseCategoryRepository: expenseCategoryRepository,
  ));
}

/// Adds mock data to Firestore pet_profiles collection.
///
/// This is only for development purposes, and should not be used in production.
///
Future<void> addMockDataToFirestore(FirebaseFirestore firestore) async {
  try {
    final petProfilesCollection = firestore.collection('pet_profiles');

    const mockPetProfile = {
      'id': 'pet1',
      'name': 'Buddy',
      'breed': 'Golden Retriever',
      'age': 5,
      'photoUrl': '',
      'medicalHistory': 'Vaccinated for rabies and parvo',
      'gender': 'Male',
    };

    await petProfilesCollection
        .doc(mockPetProfile['id'] as String)
        .set(mockPetProfile);
    print('Mock pet profile added successfully!');
  } catch (e) {
    print('Error adding mock pet profile: $e');
  }
}

Future<void> fetchPetProfiles(FirebaseFirestore firestore) async {
  try {
    final snapshot = await firestore.collection('pet_profiles').get();
    if (snapshot.docs.isEmpty) {
      print('No pet profiles found in Firestore.');
      return;
    }
    for (var doc in snapshot.docs) {
      print('Fetched pet profile: ${doc.data()}');
    }
  } catch (e) {
    print('Error fetching pet profiles: $e');
  }
}

class MyApp extends StatelessWidget {
  final PetProfileRepositoryImpl petProfileRepository;
  final ExpenseCategoryRepositoryImpl expenseCategoryRepository;

  const MyApp({
    super.key,
    required this.petProfileRepository,
    required this.expenseCategoryRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PetProfileCubit(repository: petProfileRepository),
        ),
        BlocProvider(
          create: (_) =>
              ExpenseCategoryCubit(repository: expenseCategoryRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Pet Care Tracker',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
