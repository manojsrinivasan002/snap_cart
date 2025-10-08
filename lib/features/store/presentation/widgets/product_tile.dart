import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snap_cart/core/utility/app_radius.dart';
import 'package:snap_cart/core/utility/app_spacing.dart';
import 'package:snap_cart/features/store/data/model/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final hasDiscount = product.discountPercentage != null && product.discountPercentage! > 0;
    final discountedPrice = hasDiscount
        ? (product.price * (1 - (product.discountPercentage! / 100))).toStringAsFixed(2)
        : product.price.toStringAsFixed(2);

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.large)),
        gradient: LinearGradient(
          colors: [color.secondary, color.surface],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.onSurface,
                  borderRadius: BorderRadius.circular(AppRadius.circle),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 15, color: color.primary),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      product.rating.toString(),
                      style: text.bodySmall?.copyWith(color: color.primary),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_bag, color: color.onSurface, size: 20),
              ),
            ],
          ),
          Center(
            child: CachedNetworkImage(
              height: 100,
              width: 100,
              imageUrl: product.thumbnail,
              fit: BoxFit.contain,
              placeholder: (context, url) =>
                  SizedBox(height: 23, width: 23, child: CircularProgressIndicator(strokeWidth: 3)),
              errorWidget: (context, url, error) => Icon(Icons.broken_image),
            ),
          ),
          Divider(color: color.outline.withValues(alpha: 0.5)),
          Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
          SizedBox(height: AppSpacing.s),
          hasDiscount
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${product.price.toString()}",
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      "\$${discountedPrice.toString()}",
                      style: text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.discount, size: 15),
                        SizedBox(width: AppSpacing.xs),
                        Text("${product.discountPercentage}%"),
                      ],
                    ),
                  ],
                )
              : Text(
                  product.price.toString(),
                  style: text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }
}
