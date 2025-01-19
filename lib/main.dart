import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'models/product_list.dart';
import 'models/cart.dart';
import 'models/order_list.dart';

import 'utils/app_routes.dart';

import 'pages/product_detail_page.dart';
import 'pages/products_overview_page.dart';
import 'pages/cart_page.dart';
import 'pages/orders_page.dart';
import 'pages/products_page.dart';
import 'pages/product_form_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Criando um change notifier usa-se o 'create'
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.blue[900],
            secondary: Colors.deepOrange,
          ),
          useMaterial3: true,
          appBarTheme: ThemeData.light().appBarTheme.copyWith(
                backgroundColor: Colors.blue[900],
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'Lato',
            ),
            titleMedium: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            headlineMedium: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        routes: {
          AppRoutes.HOME: (ctx) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [Locale('pt', 'BR')],
      ),
    );
  }
}
