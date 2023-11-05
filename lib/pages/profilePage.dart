import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/models/user.dart';
import 'package:frontend_shibaa_app/pages/editpost.dart';
import 'package:frontend_shibaa_app/pages/edituser.dart';
import 'package:frontend_shibaa_app/pages/loginpage.dart';
import 'package:hive/hive.dart';
import '../Services.dart';
import 'package:frontend_shibaa_app/models/posts.dart';
import 'package:http/http.dart' as http;
import 'detailpost.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  User? user;
  Posts? posts;
  String? title;
  bool isLoading = false;
  dynamic liked;
  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    super.initState();
    getUser();
    fetchPost();
  }

  void getUser() {
    String data = _myBox.get('user');
    user = Services.parseUser(data);
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
      // backgroundColor: Colors.white,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(
            image: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/2171/2171947.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Color(0xFFF8721D),
            ),
            onPressed: () {
              _myBox.delete('user');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          )
        ],
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '486',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 60),
                        Text(
                          '397',
                          style: TextStyle(
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
                    OutlinedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                builder: (context) => const EditPage(),
                                maintainState: false,
                              ))
                              .then((onGoBack));
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(150, 50)),
                        ),
                        child: const Text('Edit',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black))),
                    const SizedBox(height: 5),
                    list()
                  ],
                ),
              ),
      ),
    );
  }

  onGoBack(dynamic value) {
    getUser();
    setState(() {});
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
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                {sendDelPost(posts!.posts[index].id.toInt())},
                            child: const Text("ลบ"),
                          ),
                        ],
                      ),
                    ),
                     PopupMenuItem(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                {sendEditPost(posts!.posts[index].id.toInt())},
                            child: const Text("แก้ไข"),
                          ),
                        ],
                      ),
                    )
                  ],
                  child: const Icon(Icons.more_vert),
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

  void sendDelPost(int id) async {
    final response = await http.delete(Uri.parse('${Services.url}/post/$id'));
    print(response.statusCode);
    if (response.statusCode == 200) {
        setState(() {});
    }
  }

  void sendEditPost(int id) async {
    final response = await http.get(Uri.parse('${Services.url}/post/$id'));
    if (response.statusCode == 200) {
      if (context.mounted) {
        _myBox.put('post', response.body);
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => const EditPost(),
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
