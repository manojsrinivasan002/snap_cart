import 'package:snap_cart/core/service/network/api_client.dart';
import 'package:snap_cart/features/store/data/datasource/category_ds.dart';
import 'package:snap_cart/features/store/data/datasource/product_ds.dart';
import 'package:snap_cart/features/store/data/repo%20imp/category_repo_imp.dart';
import 'package:snap_cart/features/store/data/repo%20imp/product_repo_imp.dart';
import 'package:snap_cart/features/store/domain/usecase/category_usecase.dart';
import 'package:snap_cart/features/store/domain/usecase/product_usecase.dart';
import 'package:snap_cart/features/store/presentation/cubit/category_cubit.dart';
import 'package:snap_cart/features/store/presentation/cubit/product_cubit.dart';

class DependencyInjection {
  static late final ApiClient _apiClient;

  // Products
  static late final ProductDs _productDs;
  static late final ProductRepoImp _productRepo;
  static late final FetchProductUsecase _fetchProductUsecase;
  static late final ProductCubit _productCubit;

  // Categories
  static late final CategoryDs _categoryDs;
  static late final CategoryRepoImp _categoryRepo;
  static late final FetchCategoriesUsecase _fetchCategoriesUsecase;
  static late final CategoryCubit _categoryCubit;

  static void init() {
    _apiClient = ApiClient();

    // Products
    _productDs = ProductDs(_apiClient);
    _productRepo = ProductRepoImp(_productDs);
    _fetchProductUsecase = FetchProductUsecase(_productRepo);
    _productCubit = ProductCubit(_fetchProductUsecase);

    // Categories
    _categoryDs = CategoryDs(_apiClient);
    _categoryRepo = CategoryRepoImp(_categoryDs);
    _fetchCategoriesUsecase = FetchCategoriesUsecase(_categoryRepo);
    _categoryCubit = CategoryCubit(_fetchCategoriesUsecase);
  }

  // Core getters
  static ApiClient get apiClient => _apiClient;
  static ProductDs get productDs => _productDs;
  static ProductRepoImp get productRepo => _productRepo;

  // Products getters
  static ProductCubit get productCubit => _productCubit;
  static FetchProductUsecase get fetchProductUsecase => _fetchProductUsecase;

  // Categories getters
  static CategoryCubit get categoryCubit => _categoryCubit;
  static FetchCategoriesUsecase get fetchCategoriesUsecase => _fetchCategoriesUsecase;
}
