import 'dart:convert';
import 'package:frontend_shibaa_app/models/post.dart';
import 'package:frontend_shibaa_app/models/posts.dart';
import 'package:frontend_shibaa_app/models/tag.dart';
import 'package:frontend_shibaa_app/models/tags.dart';
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

  static Future<Tags> getTags() async {
    try {
      final response = await http.get(Uri.parse('$url/tags'));
      if (200 == response.statusCode) {
        print(response.statusCode);
        return parseTags(response.body);
      } else {
        return Tags();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Tags();
    }
  }

  static Tags parseTags(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Tag> tags = parsed.map<Tag>((json) => Tag.fromJson(json)).toList();
    Tags p = Tags();
    p.tags = tags;
    return p;
  }

  
}