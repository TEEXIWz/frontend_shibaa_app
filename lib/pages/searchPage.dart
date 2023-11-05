import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/Services.dart';
import 'package:frontend_shibaa_app/models/users.dart';
import 'package:frontend_shibaa_app/pages/userprofilepage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class Debouncer {
  final int ms;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.ms});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: ms), action);
  }
}

class SearchPageState extends State<SearchPage> {
  final debouncer = Debouncer(ms: 1000);
  Users? users;
  User? user;
  bool isLoading = false;
  String title = '';
  bool ch = false;
  final _myBox = Hive.box('myBox');
  @override
  void initState() {
    super.initState();
    isLoading = true;
    users = Users();
    getUser();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        isLoading = false;
      });
    });
  }

  void getUser() {
    String data = _myBox.get('user');
    user = Services.parseUser(data);
  }

  Widget list() {
    return Expanded(
      child: ListView.builder(
        itemCount: users!.users.isEmpty ? 0 : users!.users.length,
        itemBuilder: (BuildContext context, int index) {
          return row(index);
        },
      ),
    );
  }

  Widget row(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      MemoryImage(base64Decode(users!.users[index].img)),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  users!.users[index].name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  sendData(users!.users[index].uid.toInt());
                },
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(
            image: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/2171/2171947.png'),
          ),
        ),
      ),
      body: Center(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (string) {
                      ch = true;
                      debouncer.run(() {
                        title = 'Searching..';
                      });
                      Services.getUsers().then((usersFromServer) {
                        setState(() {
                          users = Users.filterList(usersFromServer, string);
                        });
                      });
                    },
                    decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                ch
                ? list()
                : const Text(
                    'Search user..',
                    style: TextStyle(fontSize: 24),
                  )
              ]),
      ),
    );
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  void sendData(int id) async {
    final response = await http.get(Uri.parse('${Services.url}/user/$id'));
    if (response.statusCode == 200) {
      if (context.mounted) {
        _myBox.put('data', response.body);
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => const Userprofilepage(),
              maintainState: false,
            ))
            .then((onGoBack));
      }
    }
  }
}
