import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:scoped_model/scoped_model.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class MyScopedModel extends Model {
  Future<Post> _fetchPost() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Post.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Post _postData;
  bool _isLoading = false;
  Future<Null> fetchData() async {
    _isLoading = true;
    notifyListeners();
    _postData = await _fetchPost();
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  Post get postData => _postData;
}
