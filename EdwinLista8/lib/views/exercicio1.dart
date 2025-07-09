import 'package:flutter/material.dart';

class Exercicio1 extends StatefulWidget {
  const Exercicio1({super.key});

  @override
  State<Exercicio1> createState() => _Exercicio1State();
}

class _Exercicio1State extends State<Exercicio1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  String _resultado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Soma'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: [
            Text('A soma dos números é: $_resultado'),
            TextFormField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (int.tryParse(value) == null) {
                  return 'Número válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _controller2,
              keyboardType: TextInputType.number,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (int.tryParse(value) == null) {
                  return 'Número válido';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {

                  if (_formKey.currentState!.validate()) {
                    int num1 = int.parse(_controller1.text);
                    int num2 = int.parse(_controller2.text);
                    setState(() {
                      _resultado = (num1 + num2).toString();
                    });
                  }
                });
              },
              child: Text('Calcular'),
            ),
          ],
        ),)
      ),
    );
  }
}
