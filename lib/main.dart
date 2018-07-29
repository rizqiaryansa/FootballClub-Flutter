import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(new MaterialApp(
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url =
      "http://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League";
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(url);

    print(response.body);

    setState(() {
      var convertDataJson = json.decode(response.body);
      data = convertDataJson['teams'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Football Clubs"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Card(
              margin: const EdgeInsets.all(10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: data[index]['strTeamBadge'],
                          height: 100.0,
                          width: 100.0),
                      ),
                  Center(
                    child: new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(data[index]['strTeam'],
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: 16.0)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
