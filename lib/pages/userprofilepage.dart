import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/Services.dart';
import 'package:frontend_shibaa_app/models/posts.dart';
import 'package:frontend_shibaa_app/models/user.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'detailpost.dart';

class Userprofilepage extends StatefulWidget {
  const Userprofilepage({super.key});

  @override
  UserprofilepageState createState() => UserprofilepageState();
}

class UserprofilepageState extends State<Userprofilepage> {
  User? user;
  User? myUser;
  Posts? posts;
  String? title;
  bool isLoading = false;
  dynamic liked;
  bool isFollow = false;
  final _myBox = Hive.box('myBox');
  @override
  void initState() {
    super.initState();
    getUser();
    getMyUser();
    isfollow();
    fetchPost();
  }

  void isfollow() async{
    final data = {
      "uid" : user!.uid,
      "follower" : myUser!.uid
    };

    const url = '${Services.url}/isfollow';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(data)
    );
    if (response.statusCode == 200) {
      isFollow = true;
    }
    else{
      isFollow = false;
    }
  }

  void getUser() {
    String data = _myBox.get('data');
    user = Services.parseUser(data);
  }

  void getMyUser() {
    String data = _myBox.get('user');
    myUser = Services.parseUser(data);
  }

  void fetchPost() async {
    isLoading = true;
    title = 'Loading products...';
    posts = Posts();
    Services.getUserPosts(user!.uid.toInt()).then((postsFromServer) {
      setState(() {
        posts = postsFromServer;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFFF8721D),
              ),
              onPressed: () {
                _myBox.delete('data');
                Navigator.of(context).pop(true);
              },
            )),
      ),
      body: Container(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: _getData,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: MemoryImage(base64Decode(user!.img)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user!.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user!.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user!.follower.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 80),
                        Text(
                          user!.following.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Follower'),
                        SizedBox(width: 30),
                        Text('Following'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    !isFollow
                    ? ElevatedButton(
                      onPressed: () {
                        follow(user!.uid.toInt());
                        isFollow =true;
                        setState(() {
                            
                        });
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(150, 50)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(const Color(0xFFF8721D)),
                      ),
                      child: const Text(
                        'Follow',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                    : OutlinedButton(
                        onPressed: () {
                          unfollow(user!.uid.toInt());
                          isFollow = false;
                          setState(() {
                            
                          });
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(150, 50)),
                        ),
                        child: const Text('Following',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFF8721D)))),
                    const SizedBox(height: 5),
                    list()
                  ],
                ),
              ),
      ),
    );
  }

  void follow(int id) async{
    final data = {
      "uid" : myUser!.uid
    };

    final url = '${Services.url}/follow/$id';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(data)
    );
    if (response.statusCode == 201) {
      isfollow();
      setState(() {
      });
    }
  }

  void unfollow(int id) async{
    final data = {
      "uid" : myUser!.uid
    };
    
    final url = '${Services.url}/unfollow/$id';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(data)
    );
    if (response.statusCode == 201) {
      setState(() {});
    }
  }

  Future<void> _getData() async {
    setState(() {
      fetchPost();
      getUser();
    });
  }

  Widget list() {
    return Expanded(
      child: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: posts!.posts == null ? 0 : posts!.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return post(index);
        },
      ),
    );
  }

  Widget post(int index) {
    bool liked = false;
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      color: Colors.white,
      // child: Padding(
      //   padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      MemoryImage(base64Decode(posts!.posts[index].uimg)),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      posts!.posts[index].name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  calDateTime(posts!.posts[index].created_at),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              sendDataPost(posts!.posts[index].id.toInt());
            },
            child: Image(
                height: 270,
                fit: BoxFit.cover,
                image: MemoryImage(base64Decode(posts!.posts[index].img))),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            padding: const EdgeInsets.only(bottom: 5),
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: liked == true
                                ? const Icon(
                                    Icons.pets,
                                    color: Color(0xFFF8721D),
                                  )
                                : const Icon(
                                    Icons.pets_outlined,
                                    color: Colors.black54,
                                  )),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          posts!.posts[index].liked.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(posts!.posts[index].title),
                  ),
                ],
              )),
        ],
      ),
      // ),
    );
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  void sendDataPost(int id) async {
    final response = await http.get(Uri.parse('${Services.url}/post/$id'));
    if (response.statusCode == 200) {
      if (context.mounted) {
        _myBox.put('post', response.body);
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => const DetailPost(),
              maintainState: false,
            ))
            .then((onGoBack));
      }
    }
  }

  String calDateTime(String dt) {
    String res = '';
    if (DateTime.now().difference(DateTime.parse(dt)).inMinutes < 1) {
      res = '${DateTime.now().difference(DateTime.parse(dt)).inSeconds}s';
    } else if (DateTime.now().difference(DateTime.parse(dt)).inMinutes < 60) {
      res = '${DateTime.now().difference(DateTime.parse(dt)).inMinutes}m';
    } else if (DateTime.now().difference(DateTime.parse(dt)).inMinutes < 1440) {
      res = '${DateTime.now().difference(DateTime.parse(dt)).inHours}h';
    } else {
      res = '${DateTime.now().difference(DateTime.parse(dt)).inDays}d';
    }
    return res;
  }
}
