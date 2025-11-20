import 'package:aplicativofinal/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:aplicativofinal/models/alarme_remedio.dart';

class CadastroRemedio extends StatefulWidget {
  CadastroRemedio({super.key, this.alarmeRemedio});
  final AlarmeRemedio? alarmeRemedio;
  @override
  State<CadastroRemedio> createState() => _CadastroRemedio();
}

class _CadastroRemedio extends State<CadastroRemedio> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeCadastroController = TextEditingController();
  final TextEditingController _quantidadeCadastroController =
      TextEditingController();
  TimeOfDay? horario;
  String? tipoSelecionado;

  Future<void> _selecionarhora() async {
    TimeOfDay? novoHorario = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (novoHorario != null) {
      setState(() {
        horario = novoHorario;
      });
    }
  }

  void initState() {
    super.initState();
    if (widget.alarmeRemedio != null) {
      _nomeCadastroController.text = widget.alarmeRemedio!.nome_remedio;
      _quantidadeCadastroController.text = widget.alarmeRemedio!.quantidade
          .toString();
      horario = TimeOfDay.fromDateTime(widget.alarmeRemedio!.horario);
      tipoSelecionado = widget.alarmeRemedio!.tipoQuantidade;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(5.0),
          child: Image.asset("images/medAlert.png"),
        ),
        backgroundColor: Colors.brown[50],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  widget.alarmeRemedio == null
                      ? "Cadastrar Alarme"
                      : "Editar Alarme",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome do remédio',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: _nomeCadastroController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite o remédio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: _quantidadeCadastroController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite a quantidade';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Tipo de quantidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "comprimido",
                      child: Text("comprimido(s)"),
                    ),
                    DropdownMenuItem(
                      value: "ml",
                      child: Text("Mililitros (ml)"),
                    ),
                    DropdownMenuItem(value: "gota(s)", child: Text("Gotas")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      tipoSelecionado = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Escolha o tipo de quantidade';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    _selecionarhora();
                  },
                  icon: Icon(Icons.access_alarm),
                  label: Text(
                    horario == null
                        ? 'Selecionar horário'
                        : 'Horário: ${horario!.format(context)}',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ajustando alarme')),
                        );
                        if (horario == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Selecione um horário'),
                            ),
                          );
                          return;
                        }

                        final agora = DateTime.now();
                        final horarioconvertido = DateTime(
                          agora.year,
                          agora.month,
                          agora.day,
                          horario!.hour,
                          horario!.minute,
                        );

                        if (widget.alarmeRemedio == null) {
                          AlarmeRemedio newalarmeRemedio = AlarmeRemedio(
                            horario: horarioconvertido,
                            nome_remedio: _nomeCadastroController.text.trim(),
                            quantidade: int.parse(
                              _quantidadeCadastroController.text.trim(),
                            ),
                            tipoQuantidade: tipoSelecionado!,
                          );
                          int id = await DatabaseHelper.instance
                              .addAlarmeRemedio(newalarmeRemedio);

                          newalarmeRemedio.id = id;
                          if (!context.mounted) return;
                          Navigator.pop(context, [true]);
                        } else {
                          AlarmeRemedio alarmeAtualizado = AlarmeRemedio(
                            id: widget.alarmeRemedio!.id,
                            horario: horarioconvertido,
                            nome_remedio: _nomeCadastroController.text.trim(),
                            quantidade: int.parse(
                              _quantidadeCadastroController.text.trim(),
                            ),
                            tipoQuantidade: tipoSelecionado!,
                          );
                          await DatabaseHelper.instance.updateAlarmeRemedio(
                            alarmeAtualizado,
                          );
                          if (!context.mounted) return;
                          Navigator.pop(context, true);
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.greenAccent,
                    ),

                    child: Text(
                      "Confirmar",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
