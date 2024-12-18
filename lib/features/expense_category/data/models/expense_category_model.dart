import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';
import 'dart:convert';

class ExpenseCategoryModel extends ExpenseCategory {
  const ExpenseCategoryModel({
    required super.id,
    required super.name,
    required super.description,
  });

  // Method to create an instance from a Map
  factory ExpenseCategoryModel.fromMap(Map<String, dynamic> map) {
    return ExpenseCategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  // Method to create an instance from a JSON string
  factory ExpenseCategoryModel.fromJson(String source) {
    return ExpenseCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  // Method to convert the model to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  // Method to convert the model to a JSON string
  String toJson() {
    return json.encode(toMap());
  }
}

