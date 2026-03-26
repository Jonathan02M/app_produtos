import 'package:flutter/material.dart';
import '../models/produto.dart';
import 'cadastro_produto.dart';
import 'detalhe_produto.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos>
    with SingleTickerProviderStateMixin {
  List<Produto> produtos = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  String formatarPreco(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2)}';
  }

  void adicionarProduto(Produto produto) {
    setState(() {
      produtos.add(produto);
    });

    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📦 App Produtos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'Produtos'),
            Tab(icon: Icon(Icons.add), text: 'Adicionar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          produtos.isEmpty
              ? const Center(child: Text('Nenhum produto cadastrado'))
              : ListView.builder(
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final produto = produtos[index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: produto.imagemUrl.isNotEmpty
                            ? Image.network(produto.imagemUrl, width: 50)
                            : const Icon(Icons.image),
                        title: Text(produto.nome),
                        subtitle: Text(formatarPreco(produto.preco)),
                        trailing: IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              produtos.removeAt(index);
                            });
                          },
                        ),
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetalheProduto(produto: produto),
                            ),
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

          CadastroProduto(onSalvar: adicionarProduto),
        ],
      ),
    );
  }
}