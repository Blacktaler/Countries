import 'dart:math';

import 'package:flutter/material.dart';

class CardUI extends StatelessWidget {
  int index;
  String country;
  int s = Random().nextInt(4);
  CardUI({required this.index,required this.country});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "$index",
          child: Container(
                        width: 150,
                        padding: EdgeInsets.fromLTRB(8, 5, 5, 10),
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("http://source.unsplash.com/random/$index")),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 130),
                            Text("$country",style: TextStyle(
                              color: Colors.white
                            ),),
                            SizedBox(
                              height: 4
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,color: Colors.amber,size: 15,),
                                Text("${(index%5) },${index%(s+3)}",style: TextStyle(color: Colors.grey),)
                              ],
                            ),
                          ],
                        ),
                      ),
    );
  }
}