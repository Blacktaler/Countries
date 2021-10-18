import 'dart:convert';

import 'package:dars33/Screens/info_page.dart';
import 'package:dars33/model/countries_json.dart';
import 'package:dars33/model/weather_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class LookThrough extends StatefulWidget {
  LookThrough({required this.index, required this.data});
  int index;
  AsyncSnapshot<List<Coutries>> data;
  @override
  _LookThroughState createState() => _LookThroughState();
}

class _LookThroughState extends State<LookThrough> {
  String? t;
  Weather? _weather;
  List pictures = [
    "",
    ""
  ];
 late AsyncSnapshot<List<Coutries>> snap; 
 late int index;
  @override
  void initState() {
    snap = widget.data;
    index = widget.index;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    t = snap.data![index].capital![0];
    return Scaffold(
      body: Hero(
        tag: "${widget.index}",
              child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "http://source.unsplash.com/random/${widget.index}"),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black26,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 320),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: Icon(CupertinoIcons.cloud_sun_bolt_fill,color:Colors.amber ,size: 40,) 
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 60,
                    color: Colors.black12,
                    child:  makeWeather()

                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                widget.data.data![widget.index].name!.common.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 25),
              Text(
                '${widget.data.data![widget.index].name!.common}, ${widget.data.data![index].capital}',
                style: TextStyle(fontSize: 20, color: Colors.grey[300]),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InfoPage(
                                    index: widget.index,
                                    // countryName: snap.data![index].name!.common,
                                    country: snap,
                                  )));
                    },
                    child: Container(
                      width: 167,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Text(
                        "Preview",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: 167,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Text(
                        "Start Round",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 33),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_up_circle_fill,
                    color: Colors.white,
                  ),
                  SizedBox(width: 7),
                  Text(
                    "Swipe for detail",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Weather> getWeather()async{
    var uri = "https://api.openweathermap.org/data/2.5/weather?q=$t&appid=6679fd5d7ca03ed189b41a5d0e4f3f40";
    var response = await http.get(Uri.parse(uri));
    if(response.statusCode==200){
       var  js =json.decode(response.body);
      debugPrint(response.body);
      return Weather.fromJson(js);
    }else{
      throw Exception("There's a mistake");
    } 
  }
 Widget makeWeather(){
   return FutureBuilder(
     future: getWeather(),
     builder: (context,AsyncSnapshot<Weather> snap){
       if(snap.hasData){
          var data = snap.data;
          _weather =data;
         return Column(
           children: [
             Text("humidity: "+data!.main!.humidity.toString(),style: TextStyle(
               color: Colors.white,
               fontSize: 30
             ),),
             Text("Wind speed: "+data.wind!.speed.toString()+'m/s',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
           ],
         );
       }else if(snap.hasError){
         debugPrint(snap.error.toString());
         return Center(
           
           child: Text(snap.error.toString())
         );
       }else{
         return Center(
           child: CupertinoActivityIndicator(
             radius: 20,
             
           ),
         );
       }
     },
   );
 }
}
