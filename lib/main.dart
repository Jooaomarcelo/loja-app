import 'package:flutter/material.dart';
import 'pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Loja',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      routes: {
        '/': (ctx) => ProductsOverviewPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
