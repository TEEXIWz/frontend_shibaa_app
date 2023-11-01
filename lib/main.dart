import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/pages/loginpage.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  await Hive.initFlutter();

  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}