


import 'package:estu/models/add_story.dart';
import 'package:estu/models/story_post.dart';

import 'add_post.dart';
import 'post_item.dart';
import 'story_item.dart';
import '/models/post.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Post> _posts = [Post(title: 'Olá mundo', text: 'text')];

  final List<Story> _stories = [
    Story.create(username: 'tammy', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP34e_AXKYqnrmQm6nmX-NNjEt5xNa9EuObw&s'),
    Story.create(username: 'Edwin', imageUrl: 'https://www.shutterstock.com/image-vector/spiderman-suit-icon-logo-super-600w-2407844867.jpg'),
     Story.create(username: 'pedro', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP34e_AXKYqnrmQm6nmX-NNjEt5xNa9EuObw&s'),
  ];

  
  void addStory(Story newStory) {
    setState(() {
      _stories.add(newStory);
    });
  }

  void updateStory(String id, String newUsername, String newImageUrl) {
    setState(() {
      final index = _stories.indexWhere((story) => story.id == id);
      if (index != -1) {
        _stories[index].username = newUsername;
        _stories[index].imageUrl = newImageUrl;
      }
    });
  }

  void deleteStory(String id) {
    setState(() {
      _stories.removeWhere((story) => story.id == id);
    });
  }
  
  
  void deletePost(int index) {
    setState(() {
      _posts.removeAt(index);
    });
  }

  void atualizarCurtida(Post post) {
    setState(() {
      post.likepost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Instagram Style APP")),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: _stories.length  + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135768.png'),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AddStory()),
                                );
                                if (result != null && result is Story) {
                                  addStory(result);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text('Seu Story', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                } else {
                  final story = _stories[_stories.length - index ];
                  return StoryItem(
                    story: story,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Visualizando story de ${story.username}')),
                      );
                    },
                    onLongPress: () async {
                      final action = await _showStoryOptionsDialog(context, story);
                      if (action == 'edit') {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddStory(storyToEdit: story)),
                        );
                        if (result != null && result is Story) {
                          updateStory(result.id, result.username, result.imageUrl);
                        }
                      } else if (action == 'delete') {
                        deleteStory(story.id);
                      }
                    },
                  );
                }
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return PostItem(
                  post: _posts[index],
                  deleteItem: () => deletePost(_posts.length - index - 1),
                  curtir: () => atualizarCurtida(_posts[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPost()),
          );
          if (result != null) {
            setState(() {
              _posts.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<String?> _showStoryOptionsDialog(BuildContext context, Story story) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opções para a story de ${story.username}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Editar'),
              onPressed: () => Navigator.of(context).pop('edit'),
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () => Navigator.of(context).pop('delete'),
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}