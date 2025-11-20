class AlarmeRemedio {
  int? id;
  final DateTime horario;
  final String nome_remedio;
  int? quantidade;
  String tipoQuantidade;
  bool estaAtivo;

  AlarmeRemedio({
    required this.horario,
    required this.nome_remedio,
    this.id,
    this.quantidade,
    required this.tipoQuantidade,
    this.estaAtivo = true,
  });

  factory AlarmeRemedio.fromMap(Map<String, dynamic> map) => AlarmeRemedio(
    id: map['id'],
    horario: DateTime.parse(map['horario']),
    nome_remedio: map['nome'],
    quantidade: map['quantidade'],
    tipoQuantidade: map['tipoQuantidade'],
    estaAtivo: map['estaAtivo'] == 0 ? false : true,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'horario': horario.toIso8601String(),
      'nome': nome_remedio,
      'quantidade': quantidade,
      'tipoQuantidade': tipoQuantidade,
      'estaAtivo': estaAtivo ? 1 : 0,
    };
  }
}
