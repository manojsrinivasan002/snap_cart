import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_cart/core/utility/app_theme.dart';
import 'package:snap_cart/core/utility/dependency_injection.dart';
import 'package:snap_cart/features/store/presentation/page/store_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DependencyInjection.productCubit),
          BlocProvider(create: (context) => DependencyInjection.categoryCubit),
        ],
        child: StoreScreen(),
      ),

      theme: AppTheme.lightMode,
      themeMode: ThemeMode.system,
    );
  }
}
