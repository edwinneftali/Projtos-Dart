import 'package:flutter/material.dart';

class Exercicio2 extends StatefulWidget {
  const Exercicio2({super.key});

  @override
  State<Exercicio2> createState() => _Exercicio2State();
}

class _Exercicio2State extends State<Exercicio2> {
  final _formKey = GlobalKey<FormState>();

  String _nome = '';
  bool _saudacao = false;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nome'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Digite o seu nome:'),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),

              SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _nome = _controller.text;
                      _saudacao = true;
                    });
                  }
                },
                child: Text('Enviar'),
              ),

              SizedBox(height: 35),

              if (_saudacao) Text("Saudações $_nome"),
              SizedBox(height: 25),
              if (_saudacao) Image.asset("assets/image/imagem.jpg", height: 400)

            ],
          ),
        ),
      ),
    );
  }
}
