import 'package:aplicativofinal/services/database_helper.dart';
import 'package:aplicativofinal/views/tela_principal.dart';
import 'package:flutter/material.dart';
import 'cadastro_conta.dart';
import 'package:aplicativofinal/models/user.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _senhaLoginController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(5.0),
          child: Image.asset("images/medAlert.png"),
        ),
        backgroundColor: Colors.brown[50],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Med Alert",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'E-mail',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: _emailLoginController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (obscureText == true) {
                          setState(() {
                            obscureText = false;
                          });
                        } else {
                          setState(() {
                            obscureText = true;
                          });
                        }
                      },
                      icon: Icon(
                        obscureText == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    labelText: 'Senha',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: _senhaLoginController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite sua senha';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Cadastroconta(),
                      ),
                    );
                  },
                  child: Text(
                    "Não possui conta?",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),

                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Verificando usuário...'),
                          ),
                        );

                        final user = User(
                          email: _emailLoginController.text.trim(),
                          senha: _senhaLoginController.text.trim(),
                        );

                        bool autenticacao = await DatabaseHelper.instance
                            .autenticarUser(user);

                        if (!context.mounted) return;

                        if (autenticacao == true) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TelaPrincipal(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Usuário ou senha incorretos'),
                            ),
                          );
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.greenAccent,
                    ),

                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
