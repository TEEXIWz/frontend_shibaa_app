import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/pages/editUser.dart';
import '../Services.dart';
import 'package:frontend_shibaa_app/models/posts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Posts? posts;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    String? title;
    isLoading = true;
    title = 'Loading products...';
    posts = Posts();

    Services.getPosts().then((postsFromServer) {
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
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.network(
          'https://cdn-icons-png.flaticon.com/512/2171/2171947.png',
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/564x/26/dc/3c/26dc3c8e0b156e8eeeaf75964281058f.jpg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'LnwCatCat2000',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'รีวิวทุกอย่าง',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditPage()));
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(150, 50)),
                      ),
                      child: const Text('Edit',
                          style: TextStyle(fontSize: 18, color: Colors.black))),
                  const SizedBox(height: 5,),
                  post()
                ],
              ),
      ),
    );
  }

  Widget post() {
    var liked;
    return Card(
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/564x/26/dc/3c/26dc3c8e0b156e8eeeaf75964281058f.jpg"),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LnwCatCat2000",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text("1h")
                  ],
                ),
                const Spacer(),
                PopupMenuButton(
                      itemBuilder: (context) => [
                          const PopupMenuItem(
                          child: Row(
                            children: [
                                Text("ลบ"),

                            ],
                          ),
                        ),
                        // const PopupMenuItem(
                        //   child: Row(
                        //     children: [
                        //         Text("แก้ไข"),

                        //     ],
                        //   ),
                        // )
                        ],
                        child:  const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Image.network(
              "https://p16-sign-sg.lemon8cdn.com/tos-alisg-v-a3e477-sg/oUAABDIgJDA0jXedJnEvF1ebeA6IgQbbr7LTsO~tplv-sdweummd6v-shrink:1080:0:q50.webp?source=seo_feed_list&x-expires=1725386400&x-signature=wvCLLx640nBjuvcyR%2FXz1wISBAY%3D",
              width: 300,
              height: 250,
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(children: [
                IconButton(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                          )),
                  const SizedBox(width: 8,),
                  const Text("500",
                  style: TextStyle(fontSize: 16,),
                ),
              ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget list(){
  //   return Expanded(
  //     child: ListView.builder(
  //       // ignore: unnecessary_null_comparison
  //       itemCount: products!.products == null ? 0 : products!.products.length,
  //       itemBuilder: (BuildContext context, int index) {
  //       return row(index);
  //       },
  //     ),
  //   );
  // }

  // Widget row(int index){
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Container(
  //             child: Image.network(products!.products[index].image),
  //           ),Text(
  //             products!.products[index].title,
  //             style: const TextStyle(
  //                 fontSize: 14.0,
  //                 color: Colors.black,
  //             ),
  //           ),Text(
  //             "Rate: " + products!.products[index].rating.rate.toString(),
  //             style: const TextStyle(
  //                 fontSize: 14.0,
  //                 color: Colors.black,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
