import 'package:contacts/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'DBHelper.dart';

class first extends StatefulWidget {
  Map? map;

  first({this.map});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController t = TextEditingController(text: "");
  TextEditingController t1 = TextEditingController(text: "");

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DBHelper().opendb().then((value) {
      db = value;
    });
    if (widget.map != null) {
      t.text = widget.map!["title"];
      t1.text = widget.map!["subject"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                String title = t.text;
                String subject = t1.text;

                if (title.isNotEmpty && subject.isNotEmpty) {
                  String qry =
                      "insert into notes (title,subject) values ('$title','$subject')";
                  await db!.rawInsert(qry).then((value) {
                    print(value);
                  });

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => demo(),
                      ));
                }
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: t,
              decoration: InputDecoration(
                hintText: 'Enter Contect',
                labelText: 'contect',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              maxLength: 10,
              controller: t1,
              decoration: InputDecoration(
                hintText: 'Enter number',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
