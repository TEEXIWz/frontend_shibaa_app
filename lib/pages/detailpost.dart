import 'dart:convert';

import 'package:flutter/material.dart';

class DetailPost extends StatefulWidget {
  const DetailPost({Key? key}) : super(key: key);

  @override
  DetailPostState createState() => DetailPostState();
}

class DetailPostState extends State<DetailPost> {
  bool liked = false;

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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/736x/e7/d3/83/e7d383ea4012a32d0bf090d85dd997c4.jpg"),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "milo",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "1h",
                ),
              ],
            ),
              
          ),
          const Image(
                  height: 300,
                  image: NetworkImage("https://i.pinimg.com/736x/b8/9d/71/b89d713bf95be0b3b184fd5f9901318c.jpg"),
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
                          onPressed: () {
                            
                          },
                          icon: liked == true
                              ? const Icon(
                                  Icons.pets,
                                  color: Color(0xFFF8721D),
                                )
                              : const Icon(
                                  Icons.pets_outlined,
                                  color: Colors.black54,
                                )
                      ),
                      const SizedBox(width: 8,),
                      const Text(
                        "0",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "gg",
                      style:
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.1
                            ),
                    ),
                  ),
                   const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ggggggggggggggggggggggggggggggggggggggggggggggggggg",
                      style:
                            TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.1
                            ),
                    ),
                  ),
                ],
              )
            ),
        ],
      ),
    );
  }
}
