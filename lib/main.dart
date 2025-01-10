import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product_list.dart';

import 'utils/app_routes.dart';

import 'pages/product_detail_page.dart';
import 'pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Criando um change notifier usa-se o 'create'
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.blueAccent,
            secondary: Colors.deepOrange,
          ),
          useMaterial3: true,
          appBarTheme: ThemeData.light().appBarTheme.copyWith(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'Lato',
            ),
            titleMedium: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        routes: {
          AppRoutes.HOME: (ctx) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
