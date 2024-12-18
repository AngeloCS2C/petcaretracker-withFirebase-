import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/expense_category.dart';

class ExpenseCategoryRemoteDataSource {
  final FirebaseFirestore firestore;

  ExpenseCategoryRemoteDataSource(this.firestore);

  // Create a new ExpenseCategory
  Future<void> createExpenseCategory(ExpenseCategory category) async {
    try {
      await firestore.collection('expense_categories').doc(category.id).set(category.toMap());
    } catch (e) {
      throw Exception('Error creating expense category: $e');
    }
  }

  // Fetch all ExpenseCategories
  Future<List<ExpenseCategory>> getAllExpenseCategories() async {
    try {
      final querySnapshot = await firestore.collection('expense_categories').get();
      return querySnapshot.docs.map((doc) {
        return ExpenseCategory.fromMap(doc.id, doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Error fetching expense categories: $e');
    }
  }

  // Update an existing ExpenseCategory
  Future<void> updateExpenseCategory(String id, Map<String, dynamic> updates) async {
    try {
      await firestore.collection('expense_categories').doc(id).update(updates);
    } catch (e) {
      throw Exception('Error updating expense category: $e');
    }
  }

  // Delete an ExpenseCategory
  Future<void> deleteExpenseCategory(String id) async {
    try {
      await firestore.collection('expense_categories').doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting expense category: $e');
    }
  }
}
