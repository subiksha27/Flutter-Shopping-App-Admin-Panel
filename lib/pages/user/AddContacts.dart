import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/models/store.dart';
import 'package:flutter_app1/models1/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContacts extends StatelessWidget {
  static const routeName = '/AddContacts';
  static String id = 'AddContacts';
  String _name, _designation, _salary, _joinDate, _qualification;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Form(
        key: _globalKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        CustomTextField(
        hint: 'Employee Name',
        onClick: (value) {
          _name=value;

    },
    ),
    SizedBox(
    height: 10,
    ),
    CustomTextField(
    onClick: (value) {
    _designation= value;
    },
    hint: 'Designation',
    ),
    SizedBox(
    height: 10,
    ),
    CustomTextField(
    onClick: (value) {
      _salary=value;
    },
    hint: 'Salary',
    ),
    SizedBox(
    height: 10,
    ),
    CustomTextField(
    onClick: (value) {
      _joinDate=value;
    },
    hint: 'Join Date',
    ),
    SizedBox(
    height: 10,
    ),
          CustomTextField(
            onClick: (value) {
              _qualification=value;
            },
            hint: 'Qualification',
          ),
          SizedBox(
            height: 10,
          ),

    RaisedButton(
    onPressed: () async{
      _globalKey.currentState.save();
        Firestore.instance.collection('/posts').document().setData({'title':_name,'content':_designation,'Salary':_salary,'JoinDate':_joinDate,'Qualification':_qualification});

    },


    child: Text('Add Employee'),
    )
    ],
    ),

    ),);
  }
}
