import 'dart:convert';
import 'dart:io';
import 'package:frontend_shibaa_app/models/tags.dart';
import 'package:frontend_shibaa_app/models/user.dart';
import 'package:hive/hive.dart';
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
  bool isLoading = false;
  final titleController = TextEditingController();
  final desController = TextEditingController();
  User? user;
  Tags? tags;
  final _myBox = Hive.box('myBox');

  late List<String> tagNames;
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    getUser();
    fetchTag();
    
  }

  void getUser(){
    String data = _myBox.get('user');
    user = Services.parseUser(data);
  }

  void fetchTag() async{
    isLoading = true;

    tags = Tags();
      Services.getTags().then((tagsFromServer) {
        setState(() {
          tags = tagsFromServer;
          isLoading = false;
        });
        tagNames = tags!.tags.map((tag) => tag.name).toList();
      });
    
  }

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
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: MemoryImage(base64Decode(user!.img)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    user!.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 10,
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
                      pickImgIcon(),
                    ],
                  ),
               const SizedBox(
                height: 20,
              ), isLoading
              ? Container()
              : DropDownMultiSelect(
                options: tagNames,
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

  void submitData() async {
    final title = titleController.text;
    final description = desController.text;

    final data = {
      "uid": user!.uid,
      "title": title,
      "description": description,
      "img": bs64
    };

    const url = '${Services.url}/post';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(data));
    if (response.statusCode == 201) {
      int pid = jsonDecode(response.body);
      for (var i = 0; i < tagNames.length; i++) {
        if (selectedTags.contains(tagNames[i])) {
          int tid = i+1;
          final pt = {
            "pid": pid,
            "tid": tid
          };
          await http.post(
            Uri.parse('${Services.url}/backend_shibaa_app/posttag'),
            body: jsonEncode(pt)
          );
        }
      }
      if (context.mounted) {
        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BarBottom()));
      }
    }
  }
}
