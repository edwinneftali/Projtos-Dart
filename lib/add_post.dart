import 'package:flutter/material.dart';
import '/models/post.dart';

class AddPost extends StatefulWidget {
  final Post? post;
  const AddPost({super.key, this.post});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController textoController = TextEditingController();

  @override
  void dispose() {
    tituloController.dispose();
    textoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      tituloController.text = widget.post!.title;
      textoController.text = widget.post!.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.post == null
            ? const Text("Novo Post")
            : const Text("Alterando Post"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Titulo'),
                controller: tituloController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entre com um titulo';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Texto'),
                controller: textoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entre com um texto';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Salvando')));

                    if (widget.post == null) {
                      Post newPost = Post(
                        title: tituloController.text,
                        text: textoController.text,
                      );
                      Navigator.pop(context, newPost);
                    } else {
                      widget.post?.title = tituloController.text;
                      widget.post?.text = textoController.text;
                      Navigator.pop(context);
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
