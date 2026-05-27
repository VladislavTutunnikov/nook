part of 'categories_bloc.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded({required this.categories});

  final List<CategoryModel> categories;
}

class CategoriesLoadingFailure extends CategoriesState {
  CategoriesLoadingFailure({required this.error});

  final String error;
}
