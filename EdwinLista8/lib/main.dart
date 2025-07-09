
import 'package:flutter/material.dart';
import 'package:th/views/exercicio1.dart';
import 'package:th/views/exercicio2.dart';
import 'package:th/views/exercicio3.dart';
import 'package:th/views/exercicio4.dart';
import 'package:th/views/statelessteste.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'Componentes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Exercicio4(),
    );
  }
}

