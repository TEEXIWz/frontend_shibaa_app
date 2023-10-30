import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:multiselect/multiselect.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Services.dart';
import 'package:image_picker/image_picker.dart';

import 'barBottom.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? _selectImg;
  String? bs64;
  final desController = TextEditingController();

  List<String> tags = [
    'อาหาร',
    'ท่องเที่ยว',
    'กีฬา',
    'เกม',
    'การ์ตูน',
    'ความงาม',
    'สุขภาพ',
    'อื่นๆ'
  ];
  List<String> selectedTags = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(
            image: NetworkImage('https://cdn-icons-png.flaticon.com/512/2171/2171947.png'),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
              TextField(
                controller: desController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: 'พิมพ์อะไรสักอย่าง..',
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              (bs64 != null)
                  ? Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.file(
                            _selectImg!,
                            height: 300,
                            width: 350,
                            fit: BoxFit.cover,
                            scale: 0.8,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              color: Colors.white,
                              iconSize: 30,
                              onPressed: () {
                                _pickImage();
                              },
                              icon: const Icon(Icons.refresh),
                            ),
                            const Spacer(),
                            IconButton(
                              color: Colors.white,
                              iconSize: 30,
                              onPressed: () {
                                bs64 = null;
                                setState(() {});
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      profileImg(),
                    ],
                  ),
               const SizedBox(
                height: 20,
              ),
              DropDownMultiSelect(
                options: tags,
                selectedValues: selectedTags,
                onChanged: (value) {
                  setState(() {
                    selectedTags = value;
                  });
                },
                whenEmpty: 'เลือกหมวดหมู่',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  submitData();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BarBottom()));
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(400, 50)),
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

  Widget profileImg() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: Colors.grey.withOpacity(0.6)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            // boxShadow: [
            //   BoxShadow(
            //     spreadRadius: 2,
            //     blurRadius: 10,
            //     color: Colors.black.withOpacity(0.1)
            //   )
            // ],
            shape: BoxShape.rectangle,
          ),
        ),
        Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            child: IconButton(
              padding: EdgeInsets.zero,
              color: Colors.grey.withOpacity(0.6),
              onPressed: (){
                _pickImage();
              },
              icon: const Icon(
                Icons.add_a_photo_outlined,
                size: 30,
              ),
            ),
        )
      ],
    );
  }

  Future _pickImage() async {
    final returnedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);

    setState(() {
      _selectImg = File(returnedImage!.path);
    });
    List<int> imagebs64 = File(_selectImg!.path).readAsBytesSync();
    bs64 = base64Encode(imagebs64);
  }

  void submitData() async {
    final description = desController.text;

    final data = {"uid": '2', "description": description, "img": bs64};

    const url = 'http://192.168.1.15/backend_shibaa_app/post';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(data));

    print(response.body);
  }
}
