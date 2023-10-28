import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? _selectImg;
  String? bs64;
  String btnImg = 'เพิ่มรูป';
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
              const TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                maxLength: 50,
                decoration: InputDecoration(
                  hintText: 'พิมพ์อะไรสักอย่าง..',
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // (_selectImg != null) ? Image.file(_selectImg!) : Container(),
              (bs64 != null) ? Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    // height: 300,
                    // width: 350,
                    child: Image.memory(
                                  base64Decode(bs64!),
                                  height: 300,
                                  width: 350,
                                  fit: BoxFit.cover,
                                  scale: 0.8,
                                  ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: (){
                        
                      },
                      icon: const Icon(
                        Icons.clear
                      ),
                    ),
                  )
                ],
              ) : Container(),
              // (bs64 != null) ? Image.memory(
              //                     base64Decode(bs64!),
              //                     height: 300,
              //                     width: 350,
              //                     fit: BoxFit.cover,
              //                     scale: 0.8,
              //                     ) : Container(),
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
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _pickImage();
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => const BarBottom()));
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(80,40)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color(0xFFF8721D)),
                    ),
                    child: Text(
                      btnImg,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async{
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
            ],
          ),
        ),
      ),
    );
  }
  Future _pickImage() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectImg = File(returnedImage!.path);
    });
    List<int> imagebs64 = File(_selectImg!.path).readAsBytesSync();
    bs64 = base64Encode(imagebs64);
    btnImg = 'เปลี่ยนรูป';
  }
}
