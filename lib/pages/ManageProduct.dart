import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/widgets//constants.dart';
import 'package:flutter_app1/models1/product.dart';
import 'package:flutter_app1/models/store.dart';
import 'package:flutter_app1/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/models1/custom_menu.dart';
import 'package:flutter_app1/pages/AddProduct.dart';
import 'package:flutter_app1/pages/EditProduct.dart';
class ManageProduct extends StatefulWidget {
  static const routeName = '/ManageProduct';
  static String id = 'ManageProduct';
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      actions: <Widget>[
    IconButton(
    icon: Icon(

           Icons.edit,

      color: Colors.white,

    ),
      onPressed: () {
        Navigator.push(context, new  MaterialPageRoute(builder: (context) => new EditProduct()));
      },
  )
        ,],),
    backgroundColor: Colors.white,
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new AddProduct()));
      },
    ),

  body: StreamBuilder<QuerySnapshot>(
  stream: _store.loadProducts(),
  builder: (context, snapshot) {
  if (snapshot.hasData) {
  List<Product> products = [];
  for (var doc in snapshot.data.documents) {
  var data = doc.data;
  products.add(Product(
  pId: doc.documentID,
  pPrice: data[kProductPrice],
  pName: data[kProductName],
  pDescription: data[kProductDescription],
  pLocation: data[kProductLocation],
  pCategory: data[kProductCategory]));
  }
  return GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  childAspectRatio: .8,
  ),
  itemBuilder: (context, index) => Padding(
  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  child: GestureDetector(
  onTapUp: (details) async {
  double dx = details.globalPosition.dx;
  double dy = details.globalPosition.dy;
  double dx2 = MediaQuery.of(context).size.width - dx;
  double dy2 = MediaQuery.of(context).size.width - dy;
  await showMenu(
  context: context,
  position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
  items: [
  MyPopupMenuItem(
  onClick: () {

  },
  child: Text('Edit'),
  ),
  MyPopupMenuItem(
  onClick: () {
  _store.deleteProduct(products[index].pId);
  Navigator.pop(context);
  },
  child: Text('Delete'),
  ),
  ]);
  },
  child: Stack(
  children: <Widget>[
  Positioned.fill(
  child: Image(
  fit: BoxFit.fill,
  image: AssetImage(products[index].pLocation),
  ),
  ),
  Positioned(
  bottom: 0,
  child: Opacity(
  opacity: .6,
  child: Container(
  width: MediaQuery.of(context).size.width,
  height: 60,
  color: Colors.white,
  child: Padding(
  padding: EdgeInsets.symmetric(
  horizontal: 10, vertical: 5),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
  Text(
  products[index].pName,
  style:
  TextStyle(fontWeight: FontWeight.bold),
  ),
  Text('\$ ${products[index].pPrice}')

  ],
  ),
  ),
  ),
  ),
  )
  ],
  ),
  ),
  ),
  itemCount: products.length,
  );
  } else {
  return Center(child: Text('Loading...'));
  }
  },
  ),
  );
  }
  }