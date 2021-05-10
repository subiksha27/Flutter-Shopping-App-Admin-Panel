import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/pages/KidsSection.dart';
import 'dart:async';

import 'package:flutter_app1/pages/MenSection.dart';

import 'Accessory.dart';
import 'Others.dart';
import 'WomenSection.dart';


class Grid_Layout extends StatefulWidget {
  static const routeName = '/Grid_Layout';
  static String id = 'Grid_Layout';

  @override
  _Grid_LayoutState createState() => _Grid_LayoutState();
}
class _Grid_LayoutState extends State<Grid_Layout> {
  static const routeName = '/GridLayout';
  static String id = 'GridLayout';

  // final String title;
  //final IconData icon;

  //GridLayout({this.title, this.icon});
  //void initState() {
  //setState(() {
  //docText=document['docTitle'];
  //});

  // super.initState();
  //}

  @override
  Widget build(BuildContext context) {
    //final myImageAndCaption = [
    // ["images/login.jpg", "caption1"],
    // ["images/logo.jpg", "caption2"],
    //["images/signup.jpg", "this is a big text"],
    //["images/kurti.jpg", "This is almost a bigger text"],
    //["images/jacket.jpg", "oh no this a really really big text"],
    //["images/saree.jpg", "yes small one"],
    //["images/shirt.jpg", "yes"],
    //];
    //List<String> images = ["images/jacket.jpg", "https://placeimg.com/500/500/any", "https://placeimg.com/500/500/any", "https://placeimg.com/500/500/any", "https://placeimg.com/500/500/any"];//["images/login.jpg","images/logo.jpg","images/kurti.jpg","images/jacket.jpg","images/saree.jpg","images/shirt.jpg",];
    List<Widget> images = new List<Widget>();
    images.add(Image.asset('images/jacket.jpg', height: 35));
    images.add(Image.asset('images/login.jpg', height: 35));
    images.add(Image.asset('images/shirt.jpg', height: 35));
    images.add(Image.asset('images/saree.jpg', height: 35));
    images.add(Image.asset('images/kurti.jpg', height: 35));
    images.add(Image.asset('images/signup.jpg', height: 35));


    return Scaffold(

        appBar: new AppBar(
          title: new Text ('Section'),
          backgroundColor: Colors.blue[900],
        ),
        body: GridView.count(crossAxisCount: 2,
            children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  elevation: 10.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          'https://assets.abfrlcdn.com/img/app/product/3/352427-1742906-large.jpg',
                          height: 150, width: 200, fit: BoxFit.fitWidth,),
                        Container(
                          margin: EdgeInsets.only(top: 160, left: 90),
                          height: 30, width: 90,
                          child: Stack(
                            children: <Widget>[
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.push(context, new  MaterialPageRoute(builder: (context) => new MenSection()));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.redAccent,
                                          Colors.red[200]
                                        ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.topRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10.0)

                                    ),
                                  )
                              ),
                              Center(child: Text('Add', style: TextStyle(
                                  color: Colors.white),))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 152, left: 5),
                          child: Text('Men', style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  )
              ),
              Card(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  elevation: 10.0,

                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          'https://finixpost.com/wp-content/uploads/2019/02/Look-taller-in-your-indian-wear.jpg',
                          height: 150, width: 200, fit: BoxFit.fitWidth,),
                        Container(
                          margin: EdgeInsets.only(top: 160, left: 90),
                          height: 30, width: 90,
                          child: Stack(
                            children: <Widget>[
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.push(context, new  MaterialPageRoute(builder: (context) => new WomenSection()));
                                  },
                                  hoverElevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.redAccent,
                                          Colors.red[200]
                                        ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.topRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10.0)

                                    ),
                                  )
                              ),
                              Center(child: Text('Add', style: TextStyle(
                                  color: Colors.white),))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 152, left: 5),
                          child: Text('Women', style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  )
              ),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  elevation: 10.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          'https://image.slidesharecdn.com/kidswear-180203090723/95/kidswear-burberry-brand-1-638.jpg?cb=1517649663',
                          height: 150, width: 200, fit: BoxFit.fitWidth,),
                        Container(
                          margin: EdgeInsets.only(top: 160, left: 90),
                          height: 30, width: 90,
                          child: Stack(
                            children: <Widget>[
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.push(context, new  MaterialPageRoute(builder: (context) => new KidsSection()));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.redAccent,
                                          Colors.red[200]
                                        ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.topRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10.0)

                                    ),
                                  )
                              ),
                              Center(child: Text('Add', style: TextStyle(
                                  color: Colors.white),))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 152, left: 5),
                          child: Text('Kids', style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  )
              ),
              Card(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  elevation: 10.0,

                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          'https://www.khattemeethedesires.com/wp-content/uploads/fashion-accessories-1.jpg',
                          height: 150, width: 200, fit: BoxFit.fitWidth,),
                        Container(
                          margin: EdgeInsets.only(top: 160, left: 90),
                          height: 30, width: 90,
                          child: Stack(
                            children: <Widget>[
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.push(context, new  MaterialPageRoute(builder: (context) => new Accessory()));
                                  },
                                  hoverElevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.redAccent,
                                          Colors.red[200]
                                        ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.topRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10.0)

                                    ),
                                  )
                              ),
                              Center(child: Text('Add', style: TextStyle(
                                  color: Colors.white),))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 152, left: 5),
                          child: Text('Accessory', style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  )
              ),
              Card(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  elevation: 10.0,

                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_BABFozH0tOWbK73cLSHG32eFlkJUi2H2hg&usqp=CAU',
                          height: 150, width: 200, fit: BoxFit.fitWidth,),
                        Container(
                          margin: EdgeInsets.only(top: 160, left: 90),
                          height: 30, width: 90,
                          child: Stack(
                            children: <Widget>[
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.push(context, new  MaterialPageRoute(builder: (context) => new Others()));
                                  },
                                  hoverElevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.redAccent,
                                          Colors.red[200]
                                        ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.topRight,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10.0)

                                    ),
                                  )
                              ),
                              Center(child: Text('Add', style: TextStyle(
                                  color: Colors.white),))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 152, left: 5),
                          child: Text('Others', style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  )
              ),




            ])
    );
  }
////CustomScrollView(


//primary: false,
//crossAxisAlignment: CrossAxisAlignment.start,

//slivers: <Widget>[


//SliverPadding(
// padding:const EdgeInsets.only(bottom:8.0),
//sliver: SliverGrid.count(
//  mainAxisSpacing: 10.0, //horizontal space
//crossAxisSpacing: 10.0, //vertical space
//crossAxisCount: 2, //number of images for a row
//children: images
//,


//childAspectRatio: 0.75,

// new RoundedRectangleBorder(      borderRadius: new BorderRadius.circular(30.0),    ),


//              )


//),
// ] ),


// ],
//),


//);


//));

//},


//}
//}


}