import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<String> notifications = [];

  void addNotification(String notification) {
    setState(() {
      notifications.add(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.network(
            'https://cdn-icons-png.flaticon.com/512/2171/2171947.png',
          ),
      ),
    );
  }
}
