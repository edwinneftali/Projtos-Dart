# ProjtosDart
Aqui estão alguns projetos básicos que fiz no Instituto Federal do Paraná.




  import 'package:flutter/material.dart';

class Exercicio1 extends StatelessWidget {
  const Exercicio1({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Exercicio 1'),
        backgroundColor: colorScheme.inversePrimary,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            Text(
              'Bem-vindo!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
            ),

            Text('Esta é uma tela simples contendo apenas Texto. Demostra como exibir informações estáticas usando um Stateless Widget. ',
            textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}

