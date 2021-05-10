import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/ManageProduct.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:flutter_app1/pages/ListPage.dart';
import 'package:flutter_app1/pages/StockManagement.dart';
import 'package:flutter_app1/pages/TransactionStatus.dart';
import 'package:flutter_app1/pages/GridLayout.dart';
class NavDrawer extends StatelessWidget {
  static const routeName = '/NavDrawer';
  static String id = 'NavDrawer';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(

            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/logo.jpg'))),
          ),
          ListTile(
          leading:Icon(Icons.shopping_basket_outlined),
            title: Text('Section'),
            onTap: () => {Navigator.push(context, new  MaterialPageRoute(builder: (context) => new Grid_Layout())),},
          ),
          ListTile(
            leading: Icon(Icons.local_grocery_store_sharp),
            title: Text('Product'),
            onTap: () => {Navigator.push(context, new  MaterialPageRoute(builder: (context) => new ManageProduct())),}
          ),
          ListTile(
            leading: Icon(Icons.local_shipping_sharp),
            title: Text('Status of stock'),
            onTap: () => {Navigator.push(context, new  MaterialPageRoute(builder: (context) => new StockManagement())),},
          ),
          ListTile(
            leading: Icon(Icons.playlist_add_outlined),
            title: Text('Employee List'),
              onTap: () => {Navigator.push(context, new  MaterialPageRoute(builder: (context) => new ListPage())),}
          ),
          ListTile(
            leading: Icon(Icons.payments_sharp),
            title: Text('Transaction and Pending Payment'),
            onTap: () => {Navigator.push(context, new  MaterialPageRoute(builder: (context) => new TransactionStatus())),},
          ),
        ],
      ),
    );
  }
}