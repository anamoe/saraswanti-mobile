import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    this.lantaiId,
  });

  int lantaiId;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        lantaiId: json["id"],
      );
}
