import 'package:flutter_app1/pages/OrderDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/ManageProducts.dart';
import 'package:flutter_app1/pages/OrderScreen.dart';
import 'package:flutter_app1/pages/TransactionStatus.dart';
import 'package:flutter_app1/pages/user/CartScreen.dart';
import 'package:flutter_app1/pages/user/HomePage.dart';
import 'package:flutter_app1/pages/user/ProductInfo.dart';
import 'package:flutter_app1/widgets/NavDrawer.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'models/authentication.dart';
import 'package:flutter_app1/pages/AddProduct.dart';
import 'package:flutter_app1/pages/EditProduct.dart';
import 'package:flutter_app1/pages/ListPage.dart';
import 'package:flutter_app1/pages/user/AddContacts.dart';
import 'package:flutter_app1/pages/StockManagement.dart';
import 'package:flutter_app1/pages/user/AddStock.dart';
import 'package:flutter_app1/pages/GridLayout.dart';
import 'package:flutter_app1/pages/ProfileAccount.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child: MaterialApp(
        title: 'Login App',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          SignupScreen.routeName: (ctx)=> SignupScreen(),
          LoginScreen.routeName: (ctx)=> LoginScreen(),
          HomeScreen.routeName:  (ctx)=>HomeScreen(),
          AddProduct.routeName: (ctx)=>AddProduct(),
          EditProduct.routeName: (ctx)=>EditProduct(),
          ManageProducts.routeName: (ctx)=>ManageProducts(),
          OrderScreen.routeName: (ctx)=>OrderScreen(),
          OrderDetails.routeName: (ctx) =>OrderDetails(),
          CartScreen.routeName: (ctx) =>CartScreen(),
          ProductInfo.routeName: (ctx) =>ProductInfo(),
          HomePage.routeName: (ctx)=>HomePage(),
          NavDrawer.routeName: (ctx)=>NavDrawer(),
          ListPage.routeName: (ctx)=>ListPage(),
          AddContacts.routeName: (ctx)=>AddContacts(),
          StockManagement.routeName: (ctx)=>StockManagement(),
          AddStock.routeName: (ctx)=>AddStock(),
          TransactionStatus.routeName: (ctx)=>TransactionStatus(),
          Grid_Layout.routeName:(ctx)=>Grid_Layout(),
          ProfileAccount.routeName:(ctx)=>ProfileAccount(),
        },
      ),
    );
  }
}

