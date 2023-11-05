import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../Services.dart';
import '../models/post.dart';
import 'package:http/http.dart' as http;

class EditPost extends StatefulWidget {
  const EditPost({Key? key}) : super(key: key);

  @override
  EditPostState createState() => EditPostState();
}

class EditPostState extends State<EditPost> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  File? _selectImg;
  String? bs64;
  bool liked = false;
  Post? post;
  String? title;
  bool isLoading = false;
  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    super.dispose();
  }

  void getPost() {
    String data = _myBox.get('post');
    post = Services.parsePost(data);
    titleController.text = post!.title;
    desController.text = post!.description;
    bs64 = post!.img;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFFF8721D),
              ),
              onPressed: () {
                _myBox.delete('post');
                Navigator.of(context).pop(true);
              },
            )),
      ),
     body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: MemoryImage(base64Decode(post!.img)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    post!.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: 'หัวเรื่อง',
                  // border: InputBorder.none,
                ),
              ),
              TextField(
                controller: desController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                maxLength: 500,
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
                          child: 
                          (_selectImg!=null)
                          ? Image.file(
                            _selectImg!,
                            height: 300,
                            width: 350,
                            fit: BoxFit.cover,
                            scale: 0.8,
                          )
                          : Image.memory(
                            base64Decode(bs64!),
                            height: 300,
                            width: 350,
                            fit: BoxFit.cover,
                            scale: 0.8,)
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
                      pickImgIcon(),
                    ],
                  ),
               const SizedBox(
                height: 20,
              ), 
              //isLoading
              // ? Container()
              // : DropDownMultiSelect(
              //   options: tagNames,
              //   selectedValues: selectedTags,
              //   onChanged: (value) {
              //     setState(() {
              //       // selectedTags = value;
              //     });
              //   },
              //   whenEmpty: 'เลือกหมวดหมู่',
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 15),
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
                      padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 15),
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
    );
  }

  void submitData() async {
    final title = titleController.text;
    final description = desController.text;

    final data = {
      "title": title,
      "description": description,
      "img": bs64
    };

    final url = '${Services.url}/post/edit/${post!.id}';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(data));
    if (response.statusCode == 201) {
      if (context.mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Widget pickImgIcon() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: Colors.grey.withOpacity(0.6)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
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
}