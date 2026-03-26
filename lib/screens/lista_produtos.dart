import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../routes/app_routes.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  List<Produto> produtos = [];

  String formatarPreco(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📦 Produtos')),
      body: produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado'))
          : ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Hero(
                      tag: produto.nome,
                      child: produto.imagemUrl.isNotEmpty
                          ? Image.network(produto.imagemUrl,
                              width: 50, fit: BoxFit.cover)
                          : const Icon(Icons.image, color: Colors.blue),
                    ),
                    title: Text(produto.nome),
                    subtitle: Text(formatarPreco(produto.preco)),
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        AppRoutes.detalhe,
                        arguments: produto,
                      );

                      if (result == 'delete') {
                        setState(() {
                          produtos.removeAt(index);
                        });
                      }

                      if (result is Produto) {
                        setState(() {
                          produtos[index] = result;
                        });
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final novoProduto =
              await Navigator.pushNamed(context, AppRoutes.cadastro);

          if (novoProduto != null) {
            setState(() {
              produtos.add(novoProduto as Produto);
            });
          }
        },
      ),
    );
  }
}