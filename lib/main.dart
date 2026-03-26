import 'package:flutter/material.dart';
import 'screens/lista_produtos.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Produtos',

      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),

      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,

      routes: {
        AppRoutes.home: (context) => const ListaProdutos(),
      },
    );
  }
}