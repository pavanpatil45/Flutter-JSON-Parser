import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://run.mocky.io/v3/d53400a3-6126-495e-9d16-0b4414b537b3"),
        //https://run.mocky.io/v3/d53400a3-6126-495e-9d16-0b4414b537b3 https://jsonplaceholder.typicode.com/posts
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
    print(data[1]["name"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Listview"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data[index]["name"]),
          );
        },
      ),
    );
  }
}