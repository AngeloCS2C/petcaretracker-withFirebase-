import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/core/errors/failure.dart';
import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';
import 'package:pet_care_tracker/features/expense_category/domain/repos/expense_repo.dart';

class ExpenseCategoryRepositoryImpl implements ExpenseCategoryRepository {
  final FirebaseFirestore firestore;

  ExpenseCategoryRepositoryImpl(this.firestore);

  @override
  Future<Either<Failure, void>> createExpenseCategory(
      ExpenseCategory expenseCategory) async {
    try {
      await firestore
          .collection('expense_categories')
          .doc(expenseCategory.id)
          .set(expenseCategory.toMap());
      return const Right(null);
    } catch (e) {
      return Left(Failure(
          message: 'Failed to create expense category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseCategory>>>
      getAllExpenseCategories() async {
    try {
      final snapshot = await firestore.collection('expense_categories').get();
      final categories = snapshot.docs
          .map((doc) => ExpenseCategory.fromMap(doc.id, doc.data()))
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(Failure(
          message: 'Failed to fetch expense categories: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ExpenseCategory>> getExpenseCategoryById(
      String id) async {
    try {
      final doc =
          await firestore.collection('expense_categories').doc(id).get();
      if (doc.exists) {
        final category = ExpenseCategory.fromMap(doc.id, doc.data()!);
        return Right(category);
      } else {
        return Left(Failure(message: 'Expense category not found'));
      }
    } catch (e) {
      return Left(Failure(
          message: 'Failed to fetch expense category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateExpenseCategory(
      String id, ExpenseCategory category) async {
    try {
      await firestore
          .collection('expense_categories')
          .doc(id)
          .update(category.toMap());
      return const Right(null);
    } catch (e) {
      return Left(Failure(
          message: 'Failed to update expense category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpenseCategory(String id) async {
    try {
      await firestore.collection('expense_categories').doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(Failure(
          message: 'Failed to delete expense category: ${e.toString()}'));
    }
  }
}
