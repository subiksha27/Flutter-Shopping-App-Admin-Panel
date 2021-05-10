import 'package:flutter/material.dart';
import 'package:flutter_app1/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/models/store.dart';
import 'package:flutter_app1/models1/product.dart';
class AddProduct extends StatelessWidget {

  static const routeName = '/AddProduct';
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation;
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
          hint: 'Product Name',
          onClick: (value) {
            _name = value;
          },
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          onClick: (value) {
            _price = value;
          },
          hint: 'Product Price',
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          onClick: (value) {
            _description = value;
          },
          hint: 'Product Description',
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          onClick: (value) {
            _category = value;
          },
          hint: 'Product Category',
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          onClick: (value) {
            _imageLocation = value;
          },
          hint: 'Product Location',
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
      if (_globalKey.currentState.validate()) {
        _globalKey.currentState.save();
        _store.addProduct(Product(
            pName: _name,
            pPrice: _price,
            pDescription: _description,
            pLocation: _imageLocation,
            pCategory: _category));
      }

      },



          child: Text('Add Product'),
        )
      ],
    ),
    ),);
  }
}