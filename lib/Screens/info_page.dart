import 'package:dars33/model/countries_json.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  InfoPage({required this.index,required this.country});
  int index;
  AsyncSnapshot<List<Coutries>> country;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int length = 20;
  List icons = List.generate(5, (index) => false);
  @override
  void initState() {
    super.initState();
    icons[0] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            width: 400,
            child: Stack(
              children: [
                Container(
                  height: 250,
                  width: 400,
                  
                  child: PageView.builder(
                    itemCount: icons.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: .3),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://source.unsplash.com/random/$index"),
                        ),
                      ),
                    ),
                    onPageChanged: (d) {
                      setState(() {
                        icons = List.generate(5, (index) => false);
                        icons[d] = true;
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 25,
                  bottom: 20,
                  child: Container(
                    width: 100,
                    height: 7,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              width: icons[index] ? 17 : 7,
                              decoration: BoxDecoration(
                                  color:
                                      icons[index] ? Colors.white : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                            )),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            width: 400,
            height: 170,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Country Names
                Text(
                  "${widget.country.data![widget.index].name!.common}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 14),
                Text(
                  "${widget.country.data![widget.index].capital![0]}, ${widget.country.data![widget.index].name!.common} ",
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 10),
                InkWell(

                  onTap: (){
                    launch('${widget.country.data![widget.index].maps!.googleMaps}');
                  },
                  child: Container(
                   width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.navigation,color: Colors.black54,size: 20,),
                  
                  ),
                ),

              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: .5
                    )
                  )
            ),
          ),

          Container(
            height: 250,
            width: 400,
            padding: EdgeInsets.symmetric(
              horizontal: 20
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text("Information",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  SizedBox(height: 20,),
                  Text('Region: ${widget.country.data![widget.index].region}',style: TextStyle(
                    fontSize: 20
                  ),),
                  SizedBox(height: 10,),
                  Text('Population: ${widget.country.data![widget.index].population}',style: TextStyle(
                    fontSize: 20
                  ),),
                  SizedBox(height: 10,),
                  Text('Subregion: ${widget.country.data![widget.index].subregion}',style: TextStyle(
                    fontSize: 20
                  ),),
                  SizedBox(height: 10,),
                  Text('UnMember: ${widget.country.data![widget.index].unMember}',style: TextStyle(
                    fontSize: 20
                  ),),
                  SizedBox(height: 10,),
                  Text('Status: ${widget.country.data![widget.index].status}',style: TextStyle(
                    fontSize: 20
                  ),),
                ],
              ),
            ),
          ),
          Container(
            height: 89.2,
            width: 400,
            // color: Colors.black87,
            child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 167,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green, width: 1),),
                      child: Text(
                        "Preview",
                        style: TextStyle(
                          color: Colors.green,
                        fontSize: 17
                        ),
                      ),
                    ),
                  ),
                  InkWell(
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
          )
        ],
      ),
    );
  }
}
