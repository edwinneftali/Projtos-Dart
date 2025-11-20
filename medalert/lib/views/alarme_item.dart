import 'package:aplicativofinal/views/cadastro_remedio.dart';
import 'package:flutter/material.dart';
import 'package:aplicativofinal/models/alarme_remedio.dart';

class AlarmeItem extends StatefulWidget {
  final AlarmeRemedio alarme;
  final Function() deleteAlarme;
  final Function()? atualizar;

  const AlarmeItem({
    super.key,
    required this.alarme,
    required this.deleteAlarme,
    this.atualizar,
  });

  @override
  State<AlarmeItem> createState() => _AlarmeItemState();
}

class _AlarmeItemState extends State<AlarmeItem> {
  @override
  Widget build(BuildContext context) {
    final hora =
        "${widget.alarme.horario.hour.toString().padLeft(2, '0')}:${widget.alarme.horario.minute.toString().padLeft(2, '0')}";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.alarm, color: Colors.green),
        title: Text(widget.alarme.nome_remedio),
        subtitle: Column(
          children: [
            Text("Horário: $hora"),
            Text(
              "Quantidade: ${widget.alarme.quantidade} ${widget.alarme.tipoQuantidade}",
            ),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.blue),
              onPressed: widget.deleteAlarme,
            ),
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CadastroRemedio(alarmeRemedio: widget.alarme),
                  ),
                );
                if (widget.atualizar != null) {
                  widget.atualizar!();
                }
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
