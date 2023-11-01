
import 'dart:convert';
import 'dart:io';
import 'package:frontend_shibaa_app/Services.dart';
import 'package:frontend_shibaa_app/models/user.dart';
import 'package:frontend_shibaa_app/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _selectImg;
  String? bs64;
  String? msg;
  User? user;
  final _myBox = Hive.box('myBox');

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (_myBox.get('user')!=null) {
      getUser();
    }
  }

  void getUser(){
    String data = _myBox.get('user');
    user = Services.parseUser(data);
    bs64 = user!.img;
    _nameController.text = user!.name;
    _usernameController.text = user!.username;
    _descriptionController.text = user!.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 90),
                // Row(
                //   children: [
                //     IconButton(
                //       icon: const Icon(Icons.arrow_back),
                //       onPressed: () => Navigator.pop(
                //         context,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 20),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: (bs64 != null) ? profileImg() : profileNoImg(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username ',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Username.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'description',
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your description.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("CANCEL",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:const Color(0xFFF8721D),
                        padding: const EdgeInsets.symmetric(horizontal: 55,vertical: 15),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        submitData();
                      },
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileNoImg() {
    return Stack(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
              border: Border.all(width: 4, color: Colors.white),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1))
              ],
              shape: BoxShape.circle,
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/219/219986.png'))),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 4, color: Colors.white),
                  color: Colors.orange),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                onPressed: () {
                  _pickImage();
                },
                icon: const Icon(Icons.add),
              ),
            ))
      ],
    );
  }

  Widget profileImg() {
    return Stack(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
              border: Border.all(width: 4, color: Colors.white),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1))
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover, image: MemoryImage(base64Decode(bs64!)))),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 4, color: Colors.white),
                  color: Colors.orange),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                onPressed: () {
                  _pickImage();
                },
                icon: const Icon(Icons.edit),
              ),
            ))
      ],
    );
  }

  Future _pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectImg = File(returnedImage!.path);
    });
    List<int> imagebs64 = File(_selectImg!.path).readAsBytesSync();
    bs64 = base64Encode(imagebs64);
  }

  void submitData() async{
    final name = _nameController.text;
    final username = _usernameController.text;
    final des = _descriptionController.text;

    final data = {
      "name" : name,
      "username" : username,
      "description" : des,
      "img" : bs64
    };

    final response = await http.put(
      Uri.parse('${Services.url}/user/edit/${user!.uid}'),
      body: jsonEncode(data)
    );
    if (response.statusCode == 201) {
      if (context.mounted) {
        final response2 = await http.get(Uri.parse('${Services.url}/user/${user!.uid}'));
        if (200 == response2.statusCode) {
          if (context.mounted) {
            _myBox.put('user', response2.body);
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage()
              )
            );
          }
        }
      }
    }
  }
}
