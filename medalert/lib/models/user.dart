class User {
  int? id;
  final String email;
  final String senha;

  User({required this.email, required this.senha, this.id});

  factory User.fromMap(Map<String, dynamic> json) =>
      User(email: json['email'], senha: json['senha'], id: json['id']);

  Map<String, dynamic> toMap() {
    return {'email': email, 'senha': senha, 'id': id};
  }
}
