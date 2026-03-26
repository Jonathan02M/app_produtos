import 'package:flutter/material.dart';
import '../screens/detalhe_produto.dart';
import '../models/produto.dart';

class AppRoutes {
  static const home = '/';
  static const detalhe = '/detalhe';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detalhe:
        final produto = settings.arguments as Produto;

        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => DetalheProduto(produto: produto),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}