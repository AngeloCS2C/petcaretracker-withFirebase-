import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';
import 'package:pet_care_tracker/features/expense_category/domain/repos/expense_repo.dart';

import '../../../../core/errors/failure.dart';

class GetExpenseCategoryById {
  final ExpenseCategoryRepository repository;

  GetExpenseCategoryById({required this.repository});

  Future<Either<Failure, ExpenseCategory>> call(String id) async =>
      repository.getExpenseCategoryById(id);
}
