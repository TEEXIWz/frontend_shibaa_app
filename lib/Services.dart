import 'dart:convert';
import 'package:frontend_shibaa_app/models/timg.dart';
import 'package:frontend_shibaa_app/models/timgs.dart';
import 'package:http/http.dart' as http;

class Services{
  static const String url = "http://192.168.1.15/backend_shibaa_app/post";

  static Future<Timgs> getTimgs() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return parseTimgs(response.body);
      } else {
        return Timgs();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Timgs();
    }
  }

  static Timgs parseTimgs(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Timg> timgs = parsed.map<Timg>((json) => Timg.fromJson(json)).toList();
    Timgs p = Timgs();
    p.timgs = timgs;
    return p;
  }

  
}