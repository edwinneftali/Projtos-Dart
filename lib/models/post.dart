class Post {
  String title;
  String text;
  bool liked;

  Post({required this.title, required this.text, this.liked = false});

  void likepost() {
    liked = !liked;
  }
}
