import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.network(
          'https://cdn-icons-png.flaticon.com/512/2171/2171947.png',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 60),
                Text(
                  '397',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 10,),
            OutlinedButton(onPressed: () {
              
            }, 
             style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(150, 50)),
              ),
            child: const Text('Edit',style: TextStyle(fontSize: 18, color: Colors.black ))
            ),
            post()
          ],
        ),
      ),
    );
  }

  Widget post() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
           const Row(
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Image.network(
            'https://media.istockphoto.com/id/1253629795/th/%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B8%96%E0%B9%88%E0%B8%B2%E0%B8%A2/tteokbokki-%E0%B8%81%E0%B8%B1%E0%B8%9A%E0%B9%84%E0%B8%82%E0%B9%88%E0%B9%83%E0%B8%99%E0%B8%8A%E0%B8%B2%E0%B8%A1%E0%B8%AA%E0%B8%B5%E0%B9%80%E0%B8%97%E0%B8%B2%E0%B8%9A%E0%B8%99%E0%B9%82%E0%B8%95%E0%B9%8A%E0%B8%B0%E0%B8%84%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%A3%E0%B8%B5%E0%B8%95-tteok-bokki-%E0%B9%80%E0%B8%9B%E0%B9%87%E0%B8%99%E0%B8%AD%E0%B8%B2%E0%B8%AB%E0%B8%B2%E0%B8%A3%E0%B9%80%E0%B8%81%E0%B8%B2%E0%B8%AB%E0%B8%A5%E0%B8%B5%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%A1%E0%B8%B5%E0%B9%80%E0%B8%84%E0%B9%89%E0%B8%81%E0%B8%82%E0%B9%89%E0%B8%B2%E0%B8%A7.jpg?s=612x612&w=0&k=20&c=AQCLOre-Y9-ciPMTrb4ARYPwEecNcRd8aH8hwvigR8o=',
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'Tteokbokki A popular Korean street food made with chewy rice cakes in a spicy sauce.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
         Row(
              children: [
                 const SizedBox(
                width: 20,
              ),
                 IconButton(
                    icon: const Icon(Icons.pets ,color: Color(0xFFF8721D),),
                    onPressed: () {
                      // Do something
                    },
                 ),
                  const Text(
                '500',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              ],
          )
        ],
      ),
    );
  }
}
