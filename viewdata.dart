import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class viewdata extends StatefulWidget {
  const viewdata({Key? key}) : super(key: key);

  @override
  State<viewdata> createState() => _viewdataState();
}
class _viewdataState extends State<viewdata> {
  // DatabaseReference starCountRef = FirebaseDatabase.instance.ref();

  List temp = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // starCountRef = FirebaseDatabase.instance.ref('Realtime Database');
    viewddddata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View data"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: temp.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(radius: 30,backgroundImage: NetworkImage("${temp[index]["img"]}"),),
            title: Text("${temp[index]["name"]}"),
            subtitle: Text("${temp[index]["id"]}"),
          );
        },
      ),
    );
  }

  Future<void> viewddddata() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref("Realtime Database");
    DatabaseEvent jj = await starCountRef.once();

    starCountRef.onValue.listen((event) {
      Map ii = jj.snapshot.value as Map;
      temp.clear();

      ii.forEach((key, value) {
        setState(() {
          temp.add(value);
        });
      });
    });
  }
}
