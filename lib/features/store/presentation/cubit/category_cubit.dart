import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_cart/features/store/domain/usecase/category_usecase.dart';
import 'package:snap_cart/features/store/presentation/state/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FetchCategoriesUsecase _fetchCategoriesUsecase;
  CategoryCubit(this._fetchCategoriesUsecase) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    final result = await _fetchCategoriesUsecase();
    result.fold((error) => Left(error), (categories) {
      emit(CategoriesLoaded(categories: categories));
    });
  }
}
