import 'package:flutter_app1/pages/ManageProduct.dart';
import 'package:flutter_app1/pages/ManageProducts.dart';
import 'package:flutter_app1/pages/EditProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/OrderDetails.dart';
import 'package:flutter_app1/pages/ProfileAccount.dart';
import 'package:flutter_app1/pages/addProduct.dart';
import 'package:flutter_app1/pages/OrderScreen.dart';
import 'package:flutter_app1/pages/user/HomePage.dart';
import 'package:flutter_app1/widgets/NavDrawer.dart';
class HomeScreen extends StatelessWidget {

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      drawer: NavDrawer(),

      appBar: AppBar(
        title: Text('Welcome to Convid'),
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Account'),
                Icon(Icons.person)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.push(context, new  MaterialPageRoute(builder: (context) => new ProfileAccount()));
             // Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
            },
          )
        ],

      ),




      body: Container(

        width: MediaQuery.of(context).size.width,
          //padding: const EdgeInsets.all(8.0), child: Text('Login')
          decoration: BoxDecoration(
           image: DecorationImage(

              //begin: Alignment.topLeft,end:Alignment.bottomRight,colors: <Color>[Colors.black,Colors.blue[700]],

              image: new AssetImage('images/bg1.jpg'),
              fit: BoxFit.cover,
              //colorFilter:ColorFilter.mode(Colors.black45,BlendMode.darken),
            ),
          ),

        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            RaisedButton(
        //padding: EdgeInsets.all(10),

    onPressed: () {
      Navigator.push(context, new  MaterialPageRoute(builder: (context) => new OrderDetails()));
    },
    child: Text('View orders'),
    ),
          RaisedButton(
            //padding: EdgeInsets.all(10),
            onPressed: () {
              Navigator.push(context, new  MaterialPageRoute(builder: (context) => new ManageProduct()));
            },
            child: Text('Manage Product'),
          ),
          RaisedButton(
          //padding: EdgeInsets.all(10),
            onPressed: () {
              Navigator.push(context, new  MaterialPageRoute(builder: (context) => new HomePage()));
            },
            child: Text('Home Page'),
          ),

    ],


    ),

        ),);

      //);

  }
}