part of 'expense_category_cubit.dart';

abstract class ExpenseCategoryState extends Equatable {
  const ExpenseCategoryState();

  @override
  List<Object> get props => [];
}

class ExpenseCategoryInitial extends ExpenseCategoryState {}

class ExpenseCategoryLoading extends ExpenseCategoryState {}

class ExpenseCategoryLoaded extends ExpenseCategoryState {
  final List<ExpenseCategory> categories;
  const ExpenseCategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class ExpenseCategoryAdded extends ExpenseCategoryState {}

class ExpenseCategoryUpdated extends ExpenseCategoryState {}

class ExpenseCategoryDeleted extends ExpenseCategoryState {}

class ExpenseCategoryError extends ExpenseCategoryState {
  final String message;
  const ExpenseCategoryError(this.message);

  @override
  List<Object> get props => [message];
}
