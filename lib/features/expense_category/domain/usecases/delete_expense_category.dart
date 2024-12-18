import 'package:dartz/dartz.dart';
import 'package:pet_care_tracker/features/expense_category/domain/repos/expense_repo.dart';

import '../../../../core/errors/failure.dart';

class DeleteExpenseCategory {
  final ExpenseCategoryRepository repository;

  DeleteExpenseCategory({required this.repository});

  Future<Either<Failure, void>> call(String id) async =>
      repository.deleteExpenseCategory(id);
}
