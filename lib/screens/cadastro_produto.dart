import 'package:flutter/material.dart';
import '../models/produto.dart';

class CadastroProduto extends StatefulWidget {
  const CadastroProduto({super.key});

  @override
  State<CadastroProduto> createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  final nomeController = TextEditingController();
  final precoController = TextEditingController();
  final imagemController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final produto =
        ModalRoute.of(context)!.settings.arguments as Produto?;

    if (produto != null) {
      nomeController.text = produto.nome;
      precoController.text = produto.preco.toString();
      imagemController.text = produto.imagemUrl;
    }
  }

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

    Navigator.pop(context, produto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
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
            ElevatedButton.icon(
              onPressed: salvar,
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}