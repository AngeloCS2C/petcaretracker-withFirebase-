import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';
import '../../../../core/errors/failure.dart';

abstract class ExpenseCategoryRepository {
  Future<Either<Failure, void>> createExpenseCategory(
      ExpenseCategory expenseCategory);
  Future<Either<Failure, List<ExpenseCategory>>> getAllExpenseCategories();
  Future<Either<Failure, ExpenseCategory>> getExpenseCategoryById(String id);
  Future<Either<Failure, void>> updateExpenseCategory(
      String id, ExpenseCategory category);
  Future<Either<Failure, void>> deleteExpenseCategory(String id);
}
