import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snap_cart/core/utility/app_radius.dart';

class MySearchField extends StatelessWidget {
  const MySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TextField(
      decoration: InputDecoration(
        hint: Text("Search products"),
        prefixIcon: Icon(Icons.search),
        isDense: true,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.outlineVariant),
          borderRadius: BorderRadius.circular(AppRadius.circle),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color.outlineVariant),
          borderRadius: BorderRadius.circular(AppRadius.circle),
        ),
      ),
    );
  }
}
