import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../Services.dart';
import '../models/post.dart';

class DetailPost extends StatefulWidget {
  const DetailPost({Key? key}) : super(key: key);

  @override
  DetailPostState createState() => DetailPostState();
}

class DetailPostState extends State<DetailPost> {
  bool liked = false;
  Post? post;
  String? title;
  bool isLoading = false;
  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    super.initState();
    getPost();
  }

  void getPost() {
    String data = _myBox.get('post');
    print(data);
    post = Services.parsePost(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.of(context).pop(true);
              },
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: MemoryImage(
                    base64Decode(post!.uimg),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post!.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  calDateTime(post!.created_at),
                ),
              ],
            ),
          ),
          Image(height: 300, image: MemoryImage(base64Decode(post!.img))),
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
                          post!.liked.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      post!.title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.1),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      post!.description,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.1),
                    ),
                  ),
                ],
              )),
        ],
      ),
      ),
    );
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
