import 'package:contacts/first.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'DBHelper.dart';


void main() {
  runApp(MaterialApp(
    home: demo(),
    debugShowCheckedModeBanner: false,
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  Database? db;
  List<Map> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DBHelper().opendb().then((value) {
      db = value;
      getdata();
    });
  }

  getdata() async {
    String qry = "select * from notes";
    await db!.rawQuery(qry).then((value) {
      print(value);
      list = value;
    });
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
        title: Text('Contact'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            Map map = list[index];
            print(map);
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return first(map: map,);
                    },
                  ),
                );
              },
              title: Text("${map["title"]}"),
              subtitle: Text("${map["subtitle"]}"),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.black,
              height: 10,
            );
          },
          itemCount: list.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => first(),
              ));
        },
        child: Icon(Icons.contact_page),
      ),
    );
  }
}
