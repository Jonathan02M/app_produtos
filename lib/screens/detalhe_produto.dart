import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../routes/app_routes.dart';

class DetalheProduto extends StatelessWidget {
  final Produto produto;

  const DetalheProduto({super.key, required this.produto});

  String formatarPreco(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final atualizado = await Navigator.pushNamed(
                context,
                AppRoutes.cadastro,
                arguments: produto,
              );

              if (atualizado != null) {
                Navigator.pop(context, atualizado);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context, 'delete');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: produto.nome,
              child: produto.imagemUrl.isNotEmpty
                  ? Image.network(produto.imagemUrl, height: 150)
                  : const Icon(Icons.image, size: 100),
            ),
            const SizedBox(height: 20),
            Text(
              produto.nome,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              formatarPreco(produto.preco),
              style: const TextStyle(
                  fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Text(produto.descricao),
          ],
        ),
      ),
    );
  }
}