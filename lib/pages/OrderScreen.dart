import 'package:flutter/material.dart';
import 'package:flutter_app1/widgets/constants.dart';
import 'package:flutter_app1/pages/OrderDetails.dart';
import 'package:flutter_app1/models/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/models1/order.dart';
class OrderScreen extends StatelessWidget {
  static const routeName = '/OrderScreen';
  @override
  static String id = 'OrdersScreen';
  final Store _store = Store();
  Widget build(BuildContext context) {
  return Scaffold(
  body: StreamBuilder<QuerySnapshot>(
  stream: _store.loadOrders(),
  builder: (context, snapshot) {
  if (!snapshot.hasData) {
  return Center(
  child: Text('there is no orders'),
  );
  } else {
  List<Order> orders = [];
  for (var doc in snapshot.data.documents) {
  orders.add(Order(
  documentId: doc.documentID,
  address: doc.data[kAddress],
  totallPrice: doc.data[kTotallPrice],
  ));
  }
  return ListView.builder(
  itemBuilder: (context, index) => Padding(
  padding: const EdgeInsets.all(20),
  child: GestureDetector(
  onTap: () {
  Navigator.pushNamed(context, OrderDetails.id,
  arguments: orders[index].documentId);
  },
  child: Container(
  height: MediaQuery.of(context).size.height * .2,
  color: kSecondaryColor,
  child: Padding(
  padding: const EdgeInsets.all(10),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  Text('Totall Price = \$${orders[index].totallPrice}',
  style: TextStyle(
  fontSize: 18, fontWeight: FontWeight.bold)),
  SizedBox(
  height: 10,
  ),
  Text(
  'Address is ${orders[index].address}',
  style: TextStyle(
  fontSize: 18, fontWeight: FontWeight.bold),
  )
  ],
  ),
  ),
  ),
  ),
  ),
  itemCount: orders.length,
  );
  }
  },
  ),
  );
  }
  }
