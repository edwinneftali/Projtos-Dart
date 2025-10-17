import 'package:estu/models/story_post.dart';
import 'package:flutter/material.dart';

class AddStory extends StatefulWidget {
  final Story? storyToEdit;
  const AddStory({super.key, this.storyToEdit});

  @override
  State<AddStory> createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.storyToEdit != null) {
      usernameController.text = widget.storyToEdit!.username;
      imageUrlController.text = widget.storyToEdit!.imageUrl;
    } //Aqui ele verifica se meu usúario está editando uma story 
    //existente. 
  }

  @override
  void dispose() {
    usernameController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storyToEdit == null ? "Novo Story" : "Editar Story"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      //aqui ele verifica se o usuario esta criando ou editando um stoy.

      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Nome de Usuário'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um nome de usuário';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Postagem',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'poste uma postagem  ';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    if (widget.storyToEdit == null) {
                      final newStory = Story.create(
                        username: usernameController.text,
                        imageUrl: imageUrlController.text,
                      );

                      Navigator.pop(context, newStory);
                    } else {
                      widget.storyToEdit!.username = usernameController.text;
                      widget.storyToEdit!.imageUrl = imageUrlController.text;
                      Navigator.pop(context, widget.storyToEdit);
                    }
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
