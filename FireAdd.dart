import 'dart:io';
import 'dart:math';
import 'package:firebase/viewdata.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class add extends StatefulWidget {
  const add({Key? key}) : super(key: key);

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  String image = "";
  bool hh = true;

  TextEditingController name1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireAdd"),
      ),
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              final ImagePicker _picker = ImagePicker();
                              // Pick an image
                              final XFile? abc = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                image = abc!.path;
                              });
                            },
                            child: Icon(Icons.image)),
                        ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              final ImagePicker _picker = ImagePicker();
                              final XFile? abc = await _picker.pickImage(
                                  source: ImageSource.camera);
                              setState(() {
                                image = abc!.path;
                              });
                            },
                            child: const Icon(Icons.camera_alt_outlined)),
                      ],
                    );
                  },
                );
              },
              child: hh
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage: FileImage(File(image)),
                      ),
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
                controller: name1,
                decoration: InputDecoration(border: OutlineInputBorder())),
          ),
          Container(
            width: 150,
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () async {
                  final storageRef = FirebaseStorage.instance.ref();
                  String name = "images${Random().nextInt(1000)}.jpg";
                final spaceRef = storageRef.child("hardik/$name");
                  await spaceRef.putFile(File(image));
                  //  1
                  final imageUrl = await storageRef.child("hardik/$name").getDownloadURL();
                  //  2
                  // spaceRef.getDownloadURL().then((value){
                  //   print(value);
                  // });
                  print("url=====$imageUrl");
                  DatabaseReference ref = FirebaseDatabase.instance.ref("Realtime Database").push();
                  String? idd = ref.key;
                  await ref.set({
                    "id": idd,
                    "name": name1.text,
                    "img": imageUrl
                  }).then((value) {
                    print("success");
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                         return viewdata();
                       },));
                    // navigator for view data
                  });
                },
                child: Center(child: Text("Submit"))),
          )
        ],
      ),
    );
  }
}
