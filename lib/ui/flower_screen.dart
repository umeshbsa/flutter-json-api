import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_api/model/flower.dart';
import 'package:flutter_json_api/ui/flower_detail_screen.dart';
import 'package:http/http.dart' as http;

class FlowerScreen extends StatefulWidget {
  @override
  _FlowerScreenState createState() => _FlowerScreenState();
}

class _FlowerScreenState extends State<FlowerScreen> {
  final String flowerURL =
      "http://services.hanselandpetal.com/feeds/flowers.json";

  List<Flower> flowers;

  bool _loadingInProgress = true;

// A function that will convert a response body into a List<Photo>
  List<Flower> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Flower>((json) => Flower.fromJson(json)).toList();
  }

  Future<List<Flower>> getJsonData() async {
    var response = await http.get(
        // Encode URl
        Uri.encodeFull(flowerURL),
        //Only accept josn response
        headers: {"Accept": "application/json"});
    setState(() {
      flowers = parsePhotos(response.body);
      _loadingInProgress = false;
    });
    return flowers;
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Http Get Json")),
      body: createToolBarAndMainUI(),
    );
  }

  Widget createToolBarAndMainUI() {
    if (_loadingInProgress) {
      return new Scaffold(
        body: new Center(
          child: new Container(
            color: Colors.white,
            child: new CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return createMainUI();
    }
  }

  Widget createMainUI() {
    return new Container(
      child: new ListView.builder(
        itemCount: flowers == null ? 0 : flowers.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FlowerDetail(flower: flowers[index]))),
              leading: new CircleAvatar(
                radius: 50.0,
                foregroundColor: Theme.of(context).primaryColor,
                backgroundImage: new NetworkImage(
                    "http://services.hanselandpetal.com/photos/" +
                        flowers[index].photo),
              ),
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(flowers[index].category,
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      new Text(flowers[index].name)
                    ],
                  ),
                ],
              ),
              subtitle: new Container(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                child: new Text(
                  flowers[index].instructions,
                  style: new TextStyle(
                      fontSize: 15.0, fontStyle: FontStyle.italic),
                ),
              ),
              contentPadding: EdgeInsets.all(10.0),
            ),
          );
        },
      ),
    );
  }
}
