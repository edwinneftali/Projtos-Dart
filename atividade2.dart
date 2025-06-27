import 'package:flutter/material.dart';

class Exercicio2 extends StatelessWidget {
  const Exercicio2({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Exercicio 2'),
        backgroundColor: colorScheme.inversePrimary,
      ),

      body: Padding(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image.asset('img/estudar.jpg', fit: BoxFit.fitWidth),
              ),

              SizedBox(height: 5),
              Text(
                'Aqui apresentamos uma imagem com texto abaixo. o tamanho da imagem deve ser definido em 150x150 para evitarmos overflow.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
