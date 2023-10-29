import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/Services.dart';
import 'package:frontend_shibaa_app/models/posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
        print(posts);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8, // กำหนดจำนวน tab
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 243, 243),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Image.network(
            'https://cdn-icons-png.flaticon.com/512/2171/2171947.png',
          ),
          bottom: const TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.redAccent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.redAccent, Colors.orangeAccent]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                color: Colors.redAccent),
            
            tabs: <Widget>[
              Tab(
                text: "ทั้งหมด",
              ),
              Tab(
                text: "อาหาร",
              ),
              Tab(
                text: "ท่องเที่ยว",
              ),
              Tab(
                text: "กีฬา",
              ),
              Tab(
                text: "เกม",
              ),
              Tab(
                text: "การ์ตูน",
              ),
              Tab(
                text: "ความงาม",
              ),
               Tab(
                text: "สุขภาพ",
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Color(0xFFF8721D)
              ),
              onPressed: () {

              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: isLoading
            ? const Center(
              child: CircularProgressIndicator(),
            ) 
            : Column(
            children: <Widget>[
              list(),
            ],
          ),
        )
        // TabBarView(
        //   children: <Widget>[
        //     SingleChildScrollView(
        //       child: Column(
        //         children: <Widget>[
        //           list()
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }

  Widget list(){
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
    return Card(
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/564x/26/dc/3c/26dc3c8e0b156e8eeeaf75964281058f.jpg"),
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
                      "LnwCatCat2000",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Spacer(),
                Text("1h"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Image.memory(base64Decode(posts!.posts[index].img),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                posts!.posts[index].description
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    padding: const EdgeInsets.only(left: 5,bottom: 3),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      liked = true;
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
                Text(
                  posts!.posts[index].liked.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }

}
