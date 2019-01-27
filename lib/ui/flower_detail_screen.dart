import 'package:flutter/material.dart';
import 'package:flutter_json_api/model/flower.dart';

class FlowerDetail extends StatelessWidget {
  final Flower flower;

  FlowerDetail({Key key, this.flower}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Flower Detail",
          style: new TextStyle(fontSize: 20.0),
        ),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          padding: EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: new Image.network(
                  "http://services.hanselandpetal.com/photos/" +
                      flower.photo,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              new Text(
                flower.name,
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              new Text(
                flower.category,
                style: new TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              ),
              new Text(
                flower.instructions,
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
