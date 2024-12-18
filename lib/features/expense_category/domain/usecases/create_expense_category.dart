import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';
import 'package:pet_care_tracker/features/expense_category/domain/repos/expense_repo.dart';

import '../../../../core/errors/failure.dart';

class CreateExpenseCategory {
  final ExpenseCategoryRepository repository;

  CreateExpenseCategory({required this.repository});

  Future<Either<Failure, void>> call(ExpenseCategory expenseCategory) async =>
      repository.createExpenseCategory(expenseCategory);
}
