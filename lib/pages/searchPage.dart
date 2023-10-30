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
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(
            image: NetworkImage('https://cdn-icons-png.flaticon.com/512/2171/2171947.png'),
          ),
        ),
      ),
      body: Center(
         child: Column(
          children: <Widget>[
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  
                },
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
          ]
         ),
      ),
    );
  }
}
