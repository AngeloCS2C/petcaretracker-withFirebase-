import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_tracker/features/expense_category/presentation/cubit/expense_category_cubit.dart';
import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';
import 'package:pet_care_tracker/features/pet_profiles/presentation/cubit/pet_profile_cubit.dart';
import 'package:pet_care_tracker/features/pet_profiles/domain/entities/pet_profile.dart';

class ExpenseCategoriesPage extends StatelessWidget {
  const ExpenseCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseCategoryCubit>().fetchExpenseCategories();
    context.read<PetProfileCubit>().fetchPetProfiles();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Categories'),
      ),
      body: BlocBuilder<ExpenseCategoryCubit, ExpenseCategoryState>(
        builder: (context, state) {
          if (state is ExpenseCategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseCategoryLoaded) {
            final categories = state.categories;

            if (categories.isEmpty) {
              return const Center(child: Text('No expense categories found.'));
            }

            return BlocBuilder<PetProfileCubit, PetProfileState>(
              builder: (context, petProfileState) {
                Map<String, String> petNameMap = {};
                if (petProfileState is PetProfileLoaded) {
                  petNameMap = {
                    for (var pet in petProfileState.profiles) pet.id: pet.name,
                  };
                }

                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final petName = petNameMap[category.id] ?? 'Unknown Pet';

                    return ListTile(
                      title: Text(category.name),
                      subtitle: Text(
                          '${category.description} \nBelongs to: $petName'),
                      isThreeLine: true,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditCategoryDialog(context, category);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<ExpenseCategoryCubit>()
                                  .deleteExpenseCategory(category.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ExpenseCategoryError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final petProfileState = context.read<PetProfileCubit>().state;
          List<PetProfile> petProfiles = [];
          if (petProfileState is PetProfileLoaded) {
            petProfiles = petProfileState.profiles;
          }

          if (petProfiles.isEmpty) {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('No Pet Profiles'),
                content: const Text(
                    'You must create at least one pet profile before adding an expense category.'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return;
          }

          await _showCreateCategoryDialog(context, petProfiles);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showCreateCategoryDialog(
      BuildContext context, List<PetProfile> petProfiles) async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    String? selectedPetId =
        petProfiles.isNotEmpty ? petProfiles.first.id : null;

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Create Expense Category'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedPetId,
                  isExpanded: true,
                  items: petProfiles.map((pet) {
                    return DropdownMenuItem<String>(
                      value: pet.id,
                      child: Text(pet.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedPetId = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Select Pet Profile'),
                ),
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
                if (selectedPetId != null && nameController.text.isNotEmpty) {
                  final category = ExpenseCategory(
                    id: selectedPetId!,
                    name: nameController.text,
                    description: descriptionController.text,
                  );
                  context
                      .read<ExpenseCategoryCubit>()
                      .createExpenseCategory(category);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please fill all fields and select a pet profile.'),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditCategoryDialog(
      BuildContext context, ExpenseCategory category) async {
    final nameController = TextEditingController(text: category.name);
    final descriptionController =
        TextEditingController(text: category.description);

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit Expense Category'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
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
                final updatedCategory = ExpenseCategory(
                  id: category.id,
                  name: nameController.text,
                  description: descriptionController.text,
                );
                context
                    .read<ExpenseCategoryCubit>()
                    .updateExpenseCategory(category.id, updatedCategory);
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
