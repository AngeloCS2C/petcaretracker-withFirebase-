import '../../domain/entities/expense_category.dart';

abstract class ExpenseCategoryRemoteDataSource {
  Future<void> createExpenseCategory(ExpenseCategory expenseCategory);
  Future<List<ExpenseCategory>> getAllExpenseCategories();
  Future<ExpenseCategory> getExpenseCategoryById(String id);
  Future<void> updateExpenseCategory(ExpenseCategory expenseCategory,
      [Map<String, dynamic> updates]);
  Future<void> deleteExpenseCategory(String id);
}
