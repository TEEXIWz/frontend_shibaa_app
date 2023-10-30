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
  bool liked = false;

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  void fetchPost() async{
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
    return DefaultTabController(
      length: 8, // กำหนดจำนวน tab
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(
              image: NetworkImage('https://cdn-icons-png.flaticon.com/512/2171/2171947.png'),
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent, Colors.orangeAccent
                ]
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)
              ),
              color: Colors.redAccent
            ),
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
        body:Container( 
          child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
          ) 
          : RefreshIndicator(
            onRefresh: _getData,
            child:Column(
              children: <Widget>[
              list(),
              ],
            )
          )
        )
      ),
    );
  }

  Future<void> _getData() async{
    setState(() {
      fetchPost();
    });
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
    return Container(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      color: Colors.white,
      // child: Padding(
      //   padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
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
                        posts!.posts[index].username,
                        style:
                            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text("1h"),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Image.memory(base64Decode(posts!.posts[index].img),
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
                      Text(
                        posts!.posts[index].liked.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      posts!.posts[index].description
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      // ),
    );
  }

}
