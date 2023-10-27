import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.network(
            'https://cdn-icons-png.flaticon.com/512/2171/2171947.png',
        ),
         actions: [
          IconButton(
            icon: const Icon(Icons.search,color: Color(0xFFF8721D)),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('This is my home page!'),
      ),
    );
  }
}
