import 'dart:convert';
import 'package:frontend_shibaa_app/models/post.dart';
import 'package:frontend_shibaa_app/models/posts.dart';
import 'package:http/http.dart' as http;

class Services{
  static const String url = "http://192.168.1.15/backend_shibaa_app";

  static Future<Posts> getPosts() async {
    try {
      final response = await http.get(Uri.parse('$url/post'));
      if (200 == response.statusCode) {
        return parsePosts(response.body);
      } else {
        return Posts();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Posts();
    }
  }

  static Future<Posts> getUserPosts() async {
    try {
      final response = await http.get(Uri.parse('$url/post/2'));
      if (200 == response.statusCode) {
        return parsePosts(response.body);
      } else {
        return Posts();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Posts();
    }
  }

  static Posts parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Post> posts = parsed.map<Post>((json) => Post.fromJson(json)).toList();
    Posts p = Posts();
    p.posts = posts;
    return p;
  }

  
}