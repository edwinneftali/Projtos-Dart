import 'package:flutter/material.dart';

class Exercicio3 extends StatefulWidget {
  const Exercicio3({super.key});

  @override
  State<Exercicio3> createState() => _Exercicio3State();
}

class _Exercicio3State extends State<Exercicio3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("BottomBar"),
        backgroundColor: Colors.orange,
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Principal'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Somar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.waving_hand),
            label: 'Saudação',
          ),
        ],
      ),
    );
  }
}
