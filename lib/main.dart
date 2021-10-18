import 'dart:convert';

import 'package:dars33/Screens/look_through_page.dart';
import 'package:dars33/UI/card_ui.dart';
import 'package:dars33/model/countries_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController();
  String _country = "Uzbekistan";
  int _activeIndex = 0;
  List countries = [];
  List _countryList = [];
  var _textKey = GlobalKey<FormFieldState>();
  String url = "https://restcountries.com/v3.1/all";

  var _coutry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getCountries(),
        builder: (context, AsyncSnapshot<List<Coutries>> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 25,
              ),
            );
          } else if (snap.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Courses",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Find a place to play golf',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            width: 300,
                            child: TextFormField(
                              controller: _controller,
                              key: _textKey,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: .1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.cyan,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              countries = [];
                              for (int i = 0; i <= 10; i++) {
                                debugPrint(_countryList[i].toString());
                                if (_controller.text.toLowerCase() == _countryList[i].toString().toLowerCase()) {
                                  countries.add(_countryList[i].toString());
                                  setState(() {});
                                  break;
                                }
                              }
                              // setState(() {
                              // });
                            },
                            child: Icon(Icons.search),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(50, 60)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 50,
                        width: 350,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nearby Countries',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  'View All',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "Near from Some Country",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            _countryList.add(snap.data![index].name!.common);
                            
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LookThrough(
                                      index: index,
                                      data: snap
                                    ),
                                  ),
                                );
                              },
                              child: CardUI(
                                  index: index,
                                  country: snap.data![index].name!.common
                                      .toString()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Top Rated",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 200,
                        width: 360,
                        color: Colors.transparent,
                        child: ListView.builder(
                          itemCount: countries.length,
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>LookThrough(index: index,data: snap)));
                                },
                                child: CardUI(index: index, country: countries[index])),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        ],
        currentIndex: _activeIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (f) {
          setState(() {
            _activeIndex = f;
          });
        },
      ),
    );
  }

  Future<List<Coutries>> _getCountries() async {
    try {
      var result = await http.get(Uri.parse(url));
      return (json.decode(result.body) as List)
          .map((e) => Coutries.fromJson(e))
          .toList();
    } catch (f) {
      debugPrint(f.toString());
      throw Exception("$f IS PROBLEM");
    }
  }
}
