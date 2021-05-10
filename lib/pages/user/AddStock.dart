import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/models/store.dart';
import 'package:flutter_app1/models1/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStock extends StatelessWidget {
  static const routeName = '/AddStock';
  static String id = 'AddStock';
  String _stock, _quantity, _lastshipped,  _rejectrepair,_grn;
  int _stocktotprice;
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
              hint: 'Stock-Category',
              onClick: (value) {
                _stock=value;

              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _quantity= value;
              },
              hint: 'Quantity',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _lastshipped=value;
              },
              hint: 'Last Shipped On(Date)',
            ),
            SizedBox(
              height: 10,
            ),
            //CustomTextField(
              //onClick: (value) {
                //_stocktotprice=value;
              //},
              //hint: 'Total price of Stock ',
            //),
            //SizedBox(
              //height: 10,
            //),
            CustomTextField(
              onClick: (value) {
                _rejectrepair=value;
              },
              hint: 'Rejection-Repair',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _grn=value;
              },
              hint: 'Goods Receipt Note',
            ),
            SizedBox(
              height: 10,
            ),

            RaisedButton(
              onPressed: () async{
                _globalKey.currentState.save();
                Firestore.instance.collection('/stocks').document().setData({'Stock-Category':_stock,'Quantity':_quantity,'Last-Shipped-On(Date)':_lastshipped,'Rejection-Repair':_rejectrepair,'Goods-Receipt-Note':_grn});

              },


              child: Text('Add Employee'),
            )
          ],
        ),

      ),);
  }
}
