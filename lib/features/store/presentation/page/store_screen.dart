import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:snap_cart/core/utility/app_spacing.dart';
import 'package:snap_cart/features/store/data/model/category.dart';
import 'package:snap_cart/features/store/presentation/cubit/category_cubit.dart';
import 'package:snap_cart/features/store/presentation/cubit/product_cubit.dart';
import 'package:snap_cart/features/store/presentation/state/category_state.dart';
import 'package:snap_cart/features/store/presentation/state/product_state.dart';
import 'package:snap_cart/features/store/presentation/widgets/cart_tab.dart';
import 'package:snap_cart/features/store/presentation/widgets/cat_tab_bar.dart';
import 'package:snap_cart/features/store/presentation/widgets/home_tab_bar.dart';
import 'package:snap_cart/features/store/presentation/widgets/my_header_delegate.dart';
import 'package:snap_cart/features/store/presentation/widgets/my_search_field.dart';
import 'package:snap_cart/features/store/presentation/widgets/product_tile.dart';
import 'package:snap_cart/features/store/presentation/widgets/store_tab.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    context.read<ProductCubit>().fetchProducts();
    context.read<CategoryCubit>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoriesLoaded) {
          if (_tabController!.length != state.categories.length) {
            setState(() {
              _tabController!.dispose();
              _tabController = TabController(length: state.categories.length, vsync: this);
            });
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: Text("SNAP CART", style: text.titleSmall),
                centerTitle: true,
                pinned: true,
                scrolledUnderElevation: 0,
                backgroundColor: color.surface,
                expandedHeight: size.height * 0.23,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        return Center(child: Text("Loading"));
                      } else if (state is CategoriesLoaded) {
                        return CatTabBar(categories: state.categories, controller: _tabController!);
                      } else if (state is CategoriesError) {
                        return Center(child: Text(state.errMsg));
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // center horizontally
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [color.primary, color.onSurface],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds),
                            child: Icon(Icons.store, size: size.height * 0.15, color: Colors.white),
                          ),
                          SizedBox(width: AppSpacing.s),
                          Flexible(
                            child: Text(
                              "Look what we have got in our store!",
                              textAlign: TextAlign.start,
                              style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.01,
                  ),
                  child: MySearchField(),
                ),
              ),
            ],
            body: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  );
                } else if (state is ProductsLoaded) {
                  if (state.products.isEmpty) {
                    return Text("No products to show..");
                  }
                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200 &&
                          state is ProductsLoaded &&
                          state.hasMore) {
                        context.read<ProductCubit>().fetchProducts(loadMore: true);
                      }
                      return false;
                    },
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        // vertical: size.height * 0.01,
                      ),
                      itemCount: state.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.55,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductTile(product: product);
                      },
                    ),
                  );
                } else if (state is ProductsError) {
                  return Text(state.errMsg);
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
