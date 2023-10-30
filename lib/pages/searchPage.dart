
import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/Services.dart';
import 'package:frontend_shibaa_app/models/users.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class  SearchPageState extends State<SearchPage> {
  Users? users;
  String? title;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    title = 'Loading products...';
    users = Users();

    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        isLoading = false;
      });
    });
  }

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
