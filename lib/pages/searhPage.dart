import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

 

  @override
  _SearchPageState createState() => _SearchPageState();
}

class  _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.network(
            'https://cdn-icons-png.flaticon.com/512/2171/2171947.png',
            width: 10),
      ),
      body: const Center(
        child: Text('This is my search page!'),
      ),
    );
  }
}
