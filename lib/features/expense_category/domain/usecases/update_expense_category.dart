import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';
import 'package:pet_care_tracker/features/expense_category/domain/repos/expense_repo.dart';
import 'package:pet_care_tracker/core/errors/failure.dart';

class UpdateExpenseCategory {
  final ExpenseCategoryRepository repository;

  UpdateExpenseCategory({required this.repository});

  Future<Either<Failure, void>> call(
      String id, ExpenseCategory expenseCategory) async {
    return repository.updateExpenseCategory(id, expenseCategory);
  }
}
