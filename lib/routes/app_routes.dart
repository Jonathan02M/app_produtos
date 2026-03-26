import 'package:flutter/material.dart';
import '../screens/cadastro_produto.dart';
import '../screens/detalhe_produto.dart';
import '../models/produto.dart';

class AppRoutes {
  static const cadastro = '/cadastro';
  static const detalhe = '/detalhe';

  static Map<String, WidgetBuilder> routes = {
    cadastro: (context) => const CadastroProduto(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == detalhe) {
      final produto = settings.arguments as Produto;

      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => DetalheProduto(produto: produto),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    }

    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Rota não encontrada')),
      ),
    );
  }
}