import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_tracker/features/pet_profiles/presentation/cubit/pet_profile_cubit.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';

class PetProfilesPage extends StatelessWidget {
  const PetProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PetProfileCubit>().fetchPetProfiles();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Profiles'),
      ),
      body: BlocBuilder<PetProfileCubit, PetProfileState>(
        builder: (context, state) {
          if (state is PetProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PetProfileLoaded) {
            final profiles = state.profiles;
            if (profiles.isEmpty) {
              return const Center(child: Text('No pet profiles found.'));
            }
            return ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final pet = profiles[index];
                return ListTile(
                  title: Text(pet.name),
                  subtitle: Text('Breed: ${pet.breed}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditPetDialog(context, pet);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<PetProfileCubit>()
                              .deletePetProfile(pet.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is PetProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showCreatePetDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showCreatePetDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final breedController = TextEditingController();
    final ageController = TextEditingController();
    final photoUrlController = TextEditingController();
    final medicalHistoryController = TextEditingController();
    final genderController = TextEditingController(text: 'Male');

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Create Pet Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name')),
                TextField(
                    controller: breedController,
                    decoration: const InputDecoration(labelText: 'Breed')),
                TextField(
                    controller: ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number),
                TextField(
                    controller: photoUrlController,
                    decoration: const InputDecoration(labelText: 'Photo URL')),
                TextField(
                    controller: medicalHistoryController,
                    decoration:
                        const InputDecoration(labelText: 'Medical History')),
                TextField(
                    controller: genderController,
                    decoration: const InputDecoration(labelText: 'Gender')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final pet = PetProfile(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  breed: breedController.text,
                  age: int.tryParse(ageController.text) ?? 0,
                  photoUrl: photoUrlController.text,
                  medicalHistory: medicalHistoryController.text,
                  gender: genderController.text,
                );
                context.read<PetProfileCubit>().createPetProfile(pet);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditPetDialog(BuildContext context, PetProfile pet) async {
    final nameController = TextEditingController(text: pet.name);
    final breedController = TextEditingController(text: pet.breed);
    final ageController = TextEditingController(text: pet.age.toString());
    final photoUrlController = TextEditingController(text: pet.photoUrl);
    final medicalHistoryController =
        TextEditingController(text: pet.medicalHistory);
    final genderController = TextEditingController(text: pet.gender);

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit Pet Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name')),
                TextField(
                    controller: breedController,
                    decoration: const InputDecoration(labelText: 'Breed')),
                TextField(
                    controller: ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number),
                TextField(
                    controller: photoUrlController,
                    decoration: const InputDecoration(labelText: 'Photo URL')),
                TextField(
                    controller: medicalHistoryController,
                    decoration:
                        const InputDecoration(labelText: 'Medical History')),
                TextField(
                    controller: genderController,
                    decoration: const InputDecoration(labelText: 'Gender')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedPet = PetProfile(
                  id: pet.id,
                  name: nameController.text,
                  breed: breedController.text,
                  age: int.tryParse(ageController.text) ?? 0,
                  photoUrl: photoUrlController.text,
                  medicalHistory: medicalHistoryController.text,
                  gender: genderController.text,
                );
                context
                    .read<PetProfileCubit>()
                    .updatePetProfile(pet.id, updatedPet);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
