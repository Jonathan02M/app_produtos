import 'package:flutter/material.dart';
import '../models/produto.dart';

class CadastroProduto extends StatefulWidget {
  final Function(Produto) onSalvar;

  const CadastroProduto({super.key, required this.onSalvar});

  @override
  State<CadastroProduto> createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  final nomeController = TextEditingController();
  final precoController = TextEditingController();
  final imagemController = TextEditingController();

  void salvar() {
    if (nomeController.text.isEmpty || precoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    final produto = Produto(
      nome: nomeController.text,
      preco: double.parse(precoController.text),
      descricao: 'Produto top 🚀',
      imagemUrl: imagemController.text,
    );

    widget.onSalvar(produto);

    nomeController.clear();
    precoController.clear();
    imagemController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            decoration: const InputDecoration(labelText: 'URL da Imagem'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: salvar,
            child: const Text('Salvar'),
          )
        ],
      ),
    );
  }
}