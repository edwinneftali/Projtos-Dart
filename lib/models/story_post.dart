
class Story {
  final String id;
  String username;
  String imageUrl; 
  Story({
    required String id,
    required this.username,
    required this.imageUrl,
  }) : id = id;

  factory Story.create({required username,required String imageUrl}){
    return Story(id: DateTime.now().microsecondsSinceEpoch.toString(), 
    username: username,
    imageUrl: imageUrl);
  }
}