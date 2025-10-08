// features/store/presentation/cubit/category_state.dart
import 'package:equatable/equatable.dart';
import 'package:snap_cart/features/store/data/model/category.dart';

class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoryState {}

class CategoriesLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<Category> categories;

  CategoriesLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoriesError extends CategoryState {
  final String errMsg;

  CategoriesError({required this.errMsg});

  @override
  List<Object?> get props => [errMsg];
}
