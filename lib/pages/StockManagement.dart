import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app1/pages/user/AddContacts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app1/pages/user/AddStock.dart';
//import 'package:charts_flutter/flutter.dart';

class StockManagement extends StatefulWidget {
  static const routeName = '/StockManagement';
  static String id = 'StockManagement';

  @override
  _StockManagementState createState() => _StockManagementState();
}
class _StockManagementState extends State<StockManagement> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("stocks").getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Page(post: post,)));
  }

  void initState() {
    super.initState();
    _data = getPosts();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar:  AppBar(
        title: Text("Stock Status"),
        backgroundColor: Colors.blue[900],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {

            Navigator.push(context, new  MaterialPageRoute(builder: (context) => new AddStock()));
          }
      ),
      body: new Column(

        children:<Widget>[

          FutureBuilder(
            future:_data,
            builder: (_,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: Text("Loading...."),
                );
              }else {

                return ListView.builder (
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index)
                    {
                      return ListTile(
                        title: Text(snapshot.data[index].data["Stock-Category"]),
                        onTap: () =>
                            navigateToDetail(snapshot.data[index]),


                      );
                    });
              }
            },),

        ],),);


  }
}
class Page extends StatefulWidget{
  final DocumentSnapshot post;
  Page({this.post});
  @override
  _StockPageState createState() => _StockPageState();
}
class _StockPageState extends State<Page>{
  Widget build(BuildContext context){
    return Scaffold(
        appBar:  AppBar(
          title: Text(widget.post.data["Stock-Category"]),
          backgroundColor: Colors.blue[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(

                Icons.delete,

                color: Colors.white,

              ),
              onPressed: () {
              },
            )
            ,],
        ),
        body:Column(
          children: <Widget>[

          DataTable(
            horizontalMargin: 6.0,
            columnSpacing: 8.0,
            headingRowHeight: 32.0,
            dataRowHeight: 80.0,
            columns:[
              DataColumn(

                label:Text("Quantity"),),

            ],
            rows: [
          DataRow(
            cells: <DataCell>[

          DataCell(Text(widget.post.data['Quantity']),),

              //, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),),
              // DataColumn(label: Text('Total-price-of-Stock', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),//, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),),

    ],),

    ],
            ),
        DataTable(

            horizontalMargin: 6.0,
            columnSpacing: 15.0,
            headingRowHeight: 32.0,
            dataRowHeight: 80.0,

            columns:[
              DataColumn(
        label:Text("Last-Shipped-On(Date)"),),],
          rows: [
        DataRow(
        cells: <DataCell>[  DataCell(Text(widget.post.data['Last-Shipped-On(Date)']),)]),]),



    DataTable(

    horizontalMargin: 6.0,
    columnSpacing: 15.0,
    headingRowHeight: 32.0,
    dataRowHeight: 80.0,

    columns:[ DataColumn(
    label:Text("Stock-Category"),),],
    rows: [
    DataRow(
    cells: <DataCell>[  DataCell( Text(widget.post.data['Stock-Category']),),]),],),

            DataTable(

              horizontalMargin: 6.0,
              columnSpacing: 15.0,
              headingRowHeight: 32.0,
              dataRowHeight: 80.0,

              columns:[
                DataColumn( label:Text('Rejection-Repair'),),//, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),),


              ],
                rows: [
            DataRow(
            cells: <DataCell>[

                  //DataCell(Text(widget.post.data["Total-price-of-Stock"?? "Empty"]),),
            DataCell(Text(widget.post.data["Rejection-Repair"]),),],


),],


            ),
        DataTable(

          horizontalMargin: 6.0,
          columnSpacing: 15.0,
          headingRowHeight: 32.0,
          dataRowHeight: 80.0,

          columns:[ DataColumn(label:Text('Goods-Receipt-Note')),//, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),),

            ],
            rows: [
            DataRow(
            cells: <DataCell>[DataCell(Text(widget.post.data["Goods-Receipt-Note"]),),],),],

        )]));


  }
}
