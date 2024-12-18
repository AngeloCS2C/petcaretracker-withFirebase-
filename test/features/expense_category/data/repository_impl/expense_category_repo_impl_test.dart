
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_care_tracker/core/errors/exceptions.dart';
import 'package:pet_care_tracker/core/errors/failure.dart';
import 'package:pet_care_tracker/features/expense_category/data/repository_impl/expense_category_repo_impl.dart';
import 'package:pet_care_tracker/features/expense_category/domain/entities/expense_category.dart';

import 'expense_category_remote_datasource.mock.dart';void main() {
  late ExpenseCategoryRepositoryImplementation expenseCategoryRepositoryUnderTest;
  late MockExpenseCategoryRemoteDataSource mockExpenseCategoryRemoteDataSource;

  setUp(() {
    mockExpenseCategoryRemoteDataSource = MockExpenseCategoryRemoteDataSource();
    expenseCategoryRepositoryUnderTest = ExpenseCategoryRepositoryImplementation(mockExpenseCategoryRemoteDataSource);
  });

  const testExpenseCategory = ExpenseCategory(
    id: '1',
    name: 'Food',
    description: 'Expenses related to pet food',
  );

  final testExpenseCategoryList = [testExpenseCategory];

  group('getExpenseCategoryById', () {
    test('should return ExpenseCategory when data source call is successful', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.getExpenseCategoryById(testExpenseCategory.id))
          .thenAnswer((_) async => testExpenseCategory);

      // Act
      final result = await expenseCategoryRepositoryUnderTest.getExpenseCategoryById(testExpenseCategory.id);

      // Assert
      expect(result, equals(Right(testExpenseCategory)));
      verify(() => mockExpenseCategoryRemoteDataSource.getExpenseCategoryById(testExpenseCategory.id)).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });

    test('should return Failure when data source call throws an exception', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.getExpenseCategoryById(testExpenseCategory.id))
          .thenThrow(Exception());

      // Act
      final result = await expenseCategoryRepositoryUnderTest.getExpenseCategoryById(testExpenseCategory.id);

      // Assert
      expect(result, isA<Left<Failure, ExpenseCategory>>());
      verify(() => mockExpenseCategoryRemoteDataSource.getExpenseCategoryById(testExpenseCategory.id)).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });
  });

  group('getAllExpenseCategories', () {
    test('should return List of ExpenseCategories when successful', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.getAllExpenseCategories())
          .thenAnswer((_) async => testExpenseCategoryList);

      // Act
      final result = await expenseCategoryRepositoryUnderTest.getAllExpenseCategories();

      // Assert
      expect(result, Right(testExpenseCategoryList));
      verify(() => mockExpenseCategoryRemoteDataSource.getAllExpenseCategories()).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });

    test('should return Failure when fetching ExpenseCategories fails', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.getAllExpenseCategories())
          .thenThrow(const APIException(message: 'Server error', statusCode: '500'));

      // Act
      final result = await expenseCategoryRepositoryUnderTest.getAllExpenseCategories();

      // Assert
      expect(result, isA<Left<Failure, List<ExpenseCategory>>>());
      verify(() => mockExpenseCategoryRemoteDataSource.getAllExpenseCategories()).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });
  });

  group('createExpenseCategory', () {
    test('should return void when the category is created successfully', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.createExpenseCategory(testExpenseCategory))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await expenseCategoryRepositoryUnderTest.createExpenseCategory(testExpenseCategory);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockExpenseCategoryRemoteDataSource.createExpenseCategory(testExpenseCategory)).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });

    test('should return Failure when category creation fails', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.createExpenseCategory(testExpenseCategory))
          .thenThrow(Exception());

      // Act
      final result = await expenseCategoryRepositoryUnderTest.createExpenseCategory(testExpenseCategory);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockExpenseCategoryRemoteDataSource.createExpenseCategory(testExpenseCategory)).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });
  });

  group('deleteExpenseCategory', () {
    test('should return void when the category is deleted successfully', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.deleteExpenseCategory('1'))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await expenseCategoryRepositoryUnderTest.deleteExpenseCategory('1');

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockExpenseCategoryRemoteDataSource.deleteExpenseCategory('1')).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });

    test('should return Failure when category deletion fails', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.deleteExpenseCategory('1'))
          .thenThrow(Exception());

      // Act
      final result = await expenseCategoryRepositoryUnderTest.deleteExpenseCategory('1');

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockExpenseCategoryRemoteDataSource.deleteExpenseCategory('1')).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });
  });

  group('updateExpenseCategory', () {
    test('should return void when the category is updated successfully', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.updateExpenseCategory(testExpenseCategory))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await expenseCategoryRepositoryUnderTest.updateExpenseCategory(testExpenseCategory);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockExpenseCategoryRemoteDataSource.updateExpenseCategory(testExpenseCategory)).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });

    test('should return Failure when category update fails', () async {
      // Arrange
      when(() => mockExpenseCategoryRemoteDataSource.updateExpenseCategory(testExpenseCategory))
          .thenThrow(Exception());

      // Act
      final result = await expenseCategoryRepositoryUnderTest.updateExpenseCategory(testExpenseCategory);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockExpenseCategoryRemoteDataSource.updateExpenseCategory(testExpenseCategory)).called(1);
      verifyNoMoreInteractions(mockExpenseCategoryRemoteDataSource);
    });
  });
}
