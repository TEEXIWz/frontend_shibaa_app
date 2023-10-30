import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend_shibaa_app/pages/SignUpPage.dart';
import 'package:frontend_shibaa_app/pages/barBottom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.network(
                'https://cdn-icons-png.flaticon.com/512/2171/2171947.png',
                width: 150),
            const SizedBox(height: 20),
            const Text(
              'frontend_shibaa_appa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 50),
                Text(
                  'Log In',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 50),
                Text(
                  'Username',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 50),
                Text(
                  'Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )),
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
              },
              child: const Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 175, 167, 245),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // submitData();
                 Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BarBottom()));
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(300, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFF8721D)),
              ),
              child: const Text(
                'Log In',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void submitData() async {
  //   final username = _usernameController.text;
  //   final pwd = _passwordController.text;

  //   final data = {
  //     "username": username,
  //     "password": pwd,
  //   };

  //   const url = 'http://192.168.1.15/backend_shibaa_app/user/login';
  //   final uri = Uri.parse(url);
  //   final response = await http.post(uri, body: jsonEncode(data));
  //   if (response.statusCode == 200) {
  //     if (context.mounted) {
  //       print(jsonDecode(response.body));
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => const BarBottom()));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ชื่อผู้ใช้หรือรหัสผ่านผิด")));
  //     print('Wrong');
  //   }
  // }
}
