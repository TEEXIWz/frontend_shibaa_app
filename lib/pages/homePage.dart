import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
              icon: const Icon(Icons.search, color: Color(0xFFF8721D)),
              onPressed: () {},
            ),
          ],
        ),
        body:const TabBarView(
          children: <Widget>[
            Card(
               clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/564x/26/dc/3c/26dc3c8e0b156e8eeeaf75964281058f.jpg'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'LnwCatCat2000',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
