import 'package:aplicativofinal/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:aplicativofinal/models/user.dart';

class Cadastroconta extends StatefulWidget {
  const Cadastroconta({super.key, this.user});
  final User? user;
  @override
  State<Cadastroconta> createState() => _CadastroConta();
}

class _CadastroConta extends State<Cadastroconta> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCadastroController =
      TextEditingController();
  final TextEditingController _senhaCadastroController =
      TextEditingController();
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
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
                  controller: _emailCadastroController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu email';
                    }
                    final emailRegex = RegExp(
                      r"^[a-zA-Z0-9.!+-_*=#$%]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Coloque um email valido';
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
                  controller: _senhaCadastroController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite sua senha';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),

                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cadastrando')),
                        );
                        if (widget.user == null) {
                          User newUser = User(
                            email: _emailCadastroController.text.trim(),
                            senha: _senhaCadastroController.text.trim(),
                          );
                          int? id = await DatabaseHelper.instance.addUser(
                            newUser,
                          );
                          if (id == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email já cadastrado')),
                            );
                          }

                          newUser.id = id;
                          if (!context.mounted) return;
                          Navigator.pop(context, [newUser]);
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
                      "Cadastre-se",
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
