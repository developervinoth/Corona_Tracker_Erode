import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(CoronaTracker());

class CoronaTracker extends StatefulWidget {
  @override
  _CoronaTrackerState createState() => _CoronaTrackerState();
}

class _CoronaTrackerState extends State<CoronaTracker> {
  Map data;
  int deathdata;
  int recovereddata;
  int activedata;

  Future fetchData() async {
    var url = 'https://api.covid19india.org/state_district_wise.json';
    http.Response fetchedData = await http.get(url);
    data = json.decode(fetchedData.body);

    this.setState(() {
      activedata = data['Tamil Nadu']['districtData']['Erode']['active'];
      deathdata = data['Tamil Nadu']['districtData']['Erode']['deceased'];
      recovereddata = data['Tamil Nadu']['districtData']['Erode']['recovered'];
    });
  }

  @override
  void initState() {
    this.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("home"))
          ],
          backgroundColor: Color(0xFFffffff),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.png'), fit: BoxFit.fill),
          ),
          child: SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              //code for GestureDetector
                              child: Container(
                                child: Center(
                                  child: Text(
                                    ('Active: $activedata'),
                                    style: TextStyle(
                                      fontFamily: 'Kalam',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                    left: 15, top: 15, right: 15),
                                height: 190,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white70),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              //code for Gesture Detector
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Recovered: $recovereddata",
                                    style: TextStyle(
                                      fontFamily: 'Kalam',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                    left: 15, top: 15, right: 15),
                                height: 190,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    //Code For Gesture Detector
                    child: Container(
                      child: Center(
                        child: Text(
                          "Deaths: $deathdata",
                          style: TextStyle(
                            fontFamily: 'Kalam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15),
                      height: 190,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  GestureDetector(
                    //Code For Gesture Detector
                    child: Container(
                      child: Center(
                        child: Text(
                          "Graph",
                          style: TextStyle(
                            fontFamily: 'Kalam',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      height: 320,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
