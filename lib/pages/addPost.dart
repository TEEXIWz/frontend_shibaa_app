import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.network(
            'https://cdn-icons-png.flaticon.com/512/2171/2171947.png',
            width: 10),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'เพิ่มรูป',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              // const SizedBox(
              //   height: 50,
              //   child: TextField(
              //     decoration: InputDecoration(
              //       hintText: 'รูป',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'เพิ่มข้อความ',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                  decoration: InputDecoration(
                    hintText: 'พิมพ์อะไรสักอย่าง..',
                    border: OutlineInputBorder(),
                  ),
              ),
              const SizedBox(height: 200),
              ElevatedButton(
                 onPressed: () {
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => const BarBottom()));
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(400,50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFF8721D)),
              ),

              child: const Text(
                'Post',
                style: TextStyle(fontSize: 18),
              ),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
