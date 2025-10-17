


import 'package:estu/add_post.dart';

import '../models/post.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final Function() deleteItem;
  final Function() curtir;

  const PostItem({
    super.key,
    required this.post,
    required this.deleteItem,
    required this.curtir,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: IconButton(
          onPressed: widget.curtir,
          icon: widget.post.liked
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
        ),
        title: Text(widget.post.title),

        subtitle: Text(widget.post.text),

        trailing: Wrap(
          children: [
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPost(post: widget.post),
                  ),
                );
                setState(() {});
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: widget.deleteItem,
              icon: const Icon(Icons.delete, color: Colors.pinkAccent),
            ),
          ],
        ),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        contentPadding: const EdgeInsets.all(6.0),
        titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
