import 'package:flutter/material.dart';
import 'package:snap_cart/features/store/data/model/category.dart';

class CatTabBar extends StatelessWidget {
  final List<Category> categories;
  final TabController controller;

  const CatTabBar({super.key, required this.categories, required this.controller});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TabBar(
      controller: controller,
      isScrollable: true,
      unselectedLabelColor: color.onSurface.withValues(alpha: 0.5),
      indicatorSize: TabBarIndicatorSize.label,
      tabAlignment: TabAlignment.start,
      tabs: categories.map((category) {
        return Tab(text: category.name);
      }).toList(),
    );
  }
}
