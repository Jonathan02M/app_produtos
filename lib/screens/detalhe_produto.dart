import 'package:flutter/material.dart';
import '../models/produto.dart';

class DetalheProduto extends StatefulWidget {
  final Produto produto;

  const DetalheProduto({super.key, required this.produto});

  @override
  State<DetalheProduto> createState() => _DetalheProdutoState();
}

class _DetalheProdutoState extends State<DetalheProduto>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late TextEditingController nomeController;
  late TextEditingController precoController;
  late TextEditingController imagemController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    nomeController = TextEditingController(text: widget.produto.nome);
    precoController =
        TextEditingController(text: widget.produto.preco.toString());
    imagemController =
        TextEditingController(text: widget.produto.imagemUrl);
  }

  String formatarPreco(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2)}';
  }

  void salvarEdicao() {
    final atualizado = Produto(
      nome: nomeController.text,
      preco: double.parse(precoController.text),
      descricao: widget.produto.descricao,
      imagemUrl: imagemController.text,
    );

    Navigator.pop(context, atualizado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produto'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Detalhes'),
            Tab(text: 'Editar'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context, 'delete');
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                widget.produto.imagemUrl.isNotEmpty
                    ? Image.network(widget.produto.imagemUrl, height: 150)
                    : const Icon(Icons.image, size: 100),
                const SizedBox(height: 20),
                Text(widget.produto.nome,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text(formatarPreco(widget.produto.preco),
                    style: const TextStyle(
                        fontSize: 20, color: Colors.green)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: precoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Preço'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: imagemController,
                  decoration:
                      const InputDecoration(labelText: 'Imagem URL'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: salvarEdicao,
                  child: const Text('Salvar Alterações'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}