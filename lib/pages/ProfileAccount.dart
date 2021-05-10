
import 'package:flutter/material.dart';
import 'package:flutter_app1/widgets/Avatar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileAccount extends StatefulWidget {
  static String routeName = '/ProfileAccount';
  static String id = 'ProfileAccount';

  @override
  _ProfileAccountState createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  //UserModel _currentUser = locator.get<UserController>().currentUser;

  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  String username,shopname,shoplocation,organisationdetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Avatar(
                    //avatarUrl: _currentUser?.avatarUrl,
                    onTap: () {},
                  ),
                  Text(
                      "Hi $username ?? 'nice to see you here.'}"),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: "Username"),
                        onSaved: (String val) {
                         username= val;
                        }
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          //Text(
                           // "Shop Name",
                            //style: Theme.of(context).textTheme.display1,
                          //),
                          TextFormField(
                            decoration: InputDecoration(hintText: "Shop Name"),
                              onSaved: (String val) {
                                shopname = val;
                              }

                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(hintText: "Shop Location"),
                              onSaved: (String val) {
                                shoplocation= val;
                              }
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(hintText: "Organisation Details"),
                              onSaved: (String val) {
                                organisationdetails= val;
                              }
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed:_sendToServer,color: Colors.blue[900], child: new Text('Save Profile',style: TextStyle(color: Colors.white))
                    ),
                  ],
                ),


              ))


        ],

      ),




    );

  }
  _sendToServer(){
    if (_key.currentState.validate() ){
      //No error in validator
      _key.currentState.save();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection('transactions');

        await reference.add({"username":"$username","shopname": "$shopname", "shoplocation": "$shoplocation","organisationdetails":"$organisationdetails"});
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }

  }
}