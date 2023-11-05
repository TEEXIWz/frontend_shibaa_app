import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/pages/addpost.dart';
import 'package:frontend_shibaa_app/pages/homePage.dart';
import 'package:frontend_shibaa_app/pages/notiPage.dart';
import 'package:frontend_shibaa_app/pages/profilePage.dart';
import 'package:frontend_shibaa_app/pages/searchpage.dart';


class BarBottom extends StatefulWidget {
  const BarBottom({super.key});
  @override
  _BarBottomState createState() => _BarBottomState();
}

class _BarBottomState extends State<BarBottom> {
  int currentInx = 0;

  final tabs = [const HomePage() ,const SearchPage() , const AddPostPage(),const NotificationsPage(),const ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentInx],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFF8721D),
        unselectedItemColor: const Color.fromARGB(255, 187, 187, 187),
        currentIndex: currentInx,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp),
              label: 'Home',
             ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Searh',
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add Post',
             ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined),
              label: 'Notifications',
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
              ),
        ],
        onTap: (index) {
          setState(() {
            currentInx = index;
          });
        },
      ),
    );
  }
}
