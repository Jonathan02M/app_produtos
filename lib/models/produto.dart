class Produto {
  String nome;
  double preco;
  String descricao;
  String imagemUrl;

  Produto({
    required this.nome,
    required this.preco,
    this.descricao = '',
    this.imagemUrl = '',
  });
}