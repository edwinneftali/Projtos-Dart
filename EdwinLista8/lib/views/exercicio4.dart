import 'package:flutter/material.dart';
import 'package:th/views/exercicio1.dart';
import 'package:th/views/exercicio2.dart';

class Exercicio4 extends StatefulWidget {
  const Exercicio4({super.key});

  @override
  State<Exercicio4> createState() => _Exercicio4State();
}

class _Exercicio4State extends State<Exercicio4> {
  int _index = 0;

  Widget _paginas() {
    switch (_index) {
      case 0:
        return Center(
          child: Text(
            'Você está na paginá principal!',
            style: TextStyle(fontSize: 20),
          ),
        );
      case 1:
        return Exercicio1();
      case 2:
        return Exercicio2();
      default:
        return Center(child: Text('Página não encontrada'));
    }
  }

  void _item(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Páginas'),
        backgroundColor: Colors.indigo,
      ),
      body: _paginas(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _item,
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
