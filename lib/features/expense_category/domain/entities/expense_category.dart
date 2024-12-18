import 'package:equatable/equatable.dart';

class ExpenseCategory extends Equatable {
  final String id;
  final String name;
  final String description;

  const ExpenseCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [id];

  // Static method to create an ExpenseCategory from a Map
  static ExpenseCategory fromMap(String id, Map<String, dynamic> map) {
    return ExpenseCategory(
      id: id,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}

// Firestore-related extensions
extension ExpenseCategoryFirestore on ExpenseCategory {
  // Convert ExpenseCategory to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  // Create an ExpenseCategory from Map
  static ExpenseCategory fromMap(String id, Map<String, dynamic> map) {
    return ExpenseCategory(
      id: id,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}
