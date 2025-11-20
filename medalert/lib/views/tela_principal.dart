import 'package:aplicativofinal/views/alarme_item.dart';
import 'package:flutter/material.dart';
import 'package:aplicativofinal/models/alarme_remedio.dart';
import 'package:aplicativofinal/services/database_helper.dart';
import 'package:aplicativofinal/views/cadastro_remedio.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  deleteAlarme(AlarmeRemedio alarmeRemedio) async {
    await DatabaseHelper.instance.removeAlarmeRemedio(alarmeRemedio.id!);
    setState(() {}); // 🔁 Recarrega a tela logo após deletar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Meus Alarmes'),
        centerTitle: true,
        leading: const Icon(Icons.medication_liquid),
        backgroundColor: Colors.brown[50],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroRemedio()),
          );

          // 🔁 Se voltou da tela de cadastro, recarrega
          if (result != null) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<AlarmeRemedio>>(
        future: DatabaseHelper.instance.getAlarmeRemediosAtivos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum alarme cadastrado',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final alarmes = snapshot.data!;
          return ListView.builder(
            itemCount: alarmes.length,
            itemBuilder: (context, index) {
              final alarme = alarmes[alarmes.length - index - 1];
              return AlarmeItem(
                alarme: alarme,
                deleteAlarme: () => deleteAlarme(alarme),
                atualizar: () => setState(() {}),
              );
            },
          );
        },
      ),
    );
  }
}
