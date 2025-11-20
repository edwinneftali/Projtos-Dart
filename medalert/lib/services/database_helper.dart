import 'dart:io';

import 'package:aplicativofinal/models/alarme_remedio.dart';
import 'package:aplicativofinal/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  static const int _version = 1;
  static const String _dbName = "medalert_db.db";

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return openDatabase(path, onCreate: _createDb, version: _version);
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users
      (id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT NOT NULL UNIQUE,
      senha TEXT NOT NULL)
      ''');

    await db.execute('''
      CREATE TABLE alarmeRemedios
      (id INTEGER PRIMARY KEY AUTOINCREMENT,
      horario TEXT NOT NULL,
      nome TEXT NOT NULL,
      quantidade INTEGER NOT NULL,
      tipoQuantidade TEXT NOT NULL,
      estaAtivo INTEGER NOT NULL
      )
      ''');
  }

  Future<int?> addUser(User newUser) async {
    Database db = await instance.database;
    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [newUser.email.trim()],
    );

    if (existing.isNotEmpty) {
      return null;
    }

    return await db.insert('users', newUser.toMap());
  }

  Future<int> addAlarmeRemedio(AlarmeRemedio newAlarm) async {
    Database db = await instance.database;
    return await db.insert('alarmeRemedios', newAlarm.toMap());
  }

  Future<bool> autenticarUser(User user) async {
    Database db = await instance.database;
    var result = await db.query(
      'users',
      columns: ['id'],
      where: 'email = ? AND senha = ?',
      whereArgs: [user.email.trim(), user.senha.trim()],
    );
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<AlarmeRemedio>> getAlarmeRemediosAtivos() async {
    // 1. Obtém a instância do banco de dados
    Database db = await instance.database;

    // 2. Executa a consulta (query)
    // - where: Filtra apenas os alarmes onde estaAtivo é igual a 1 (true)
    // - orderBy: Garante que o alarme mais próximo apareça primeiro
    var alarmeRemediosMapList = await db.query(
      'alarmeRemedios',
      where: 'estaAtivo = ?',
      whereArgs: [1], // Filtra por estaAtivo = 1
      orderBy: 'horario ASC', // Ordena pelo horário mais cedo
    );

    // 3. Verifica se a lista está vazia
    if (alarmeRemediosMapList.isEmpty) {
      return [];
    }

    // 4. Mapeia a lista de Map<String, dynamic> para List<AlarmeRemedio>
    List<AlarmeRemedio> alarmeList = alarmeRemediosMapList
        .map((item) => AlarmeRemedio.fromMap(item))
        .toList();

    // 5. Retorna a lista de alarmes ativos
    return alarmeList;
  }

  Future<int> updateAlarmeRemedio(AlarmeRemedio alarme) async {
    Database db = await instance.database;
    return await db.update(
      'alarmeRemedios',
      alarme.toMap(),
      where: 'id = ?',
      whereArgs: [alarme.id],
    );
  }

  Future<int> removeAlarmeRemedio(int id) async {
    Database db = await instance.database;
    return await db.delete('alarmeRemedios', where: 'id = ?', whereArgs: [id]);
  }
}
