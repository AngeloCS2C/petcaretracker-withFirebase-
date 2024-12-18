import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';
import 'package:pet_care_tracker/features/expense_category/domain/repos/expense_repo.dart';

part 'expense_category_state.dart';

class ExpenseCategoryCubit extends Cubit<ExpenseCategoryState> {
  final ExpenseCategoryRepository repository;

  ExpenseCategoryCubit({required this.repository})
      : super(ExpenseCategoryInitial());

  Future<void> fetchExpenseCategories() async {
    emit(ExpenseCategoryLoading());
    final result = await repository.getAllExpenseCategories();
    result.fold(
      (failure) => emit(ExpenseCategoryError(failure.message)),
      (categories) => emit(ExpenseCategoryLoaded(categories)),
    );
  }

  Future<void> createExpenseCategory(ExpenseCategory category) async {
    emit(ExpenseCategoryLoading());
    final result = await repository.createExpenseCategory(category);
    result.fold(
      (failure) => emit(ExpenseCategoryError(failure.message)),
      (_) async {
        emit(ExpenseCategoryAdded());
        await fetchExpenseCategories();
      },
    );
  }

  Future<void> updateExpenseCategory(
      String id, ExpenseCategory category) async {
    emit(ExpenseCategoryLoading());
    final result = await repository.updateExpenseCategory(id, category);
    result.fold(
      (failure) => emit(ExpenseCategoryError(failure.message)),
      (_) async {
        emit(ExpenseCategoryUpdated());
        await fetchExpenseCategories();
      },
    );
  }

  Future<void> deleteExpenseCategory(String id) async {
    emit(ExpenseCategoryLoading());
    final result = await repository.deleteExpenseCategory(id);
    result.fold(
      (failure) => emit(ExpenseCategoryError(failure.message)),
      (_) async {
        emit(ExpenseCategoryDeleted());
        await fetchExpenseCategories();
      },
    );
  }
}
