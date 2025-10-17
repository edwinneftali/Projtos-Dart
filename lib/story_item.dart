import 'package:estu/models/story_post.dart';
import 'package:flutter/material.dart';


class StoryItem extends StatelessWidget {
  final Story story;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const StoryItem({
    super.key,
    required this.onTap,
    required this.story,
    this.onLongPress,
  });

  @override 
  Widget build(BuildContext context) {
    return GestureDetector( 
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.pink, width: 2.0),
                image: DecorationImage(
                  image: NetworkImage(story.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 4),
            Text(
              story.username,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
