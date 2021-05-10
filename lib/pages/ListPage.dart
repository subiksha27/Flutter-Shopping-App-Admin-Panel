import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app1/pages/user/AddContacts.dart';
import 'package:google_fonts/google_fonts.dart';
class ListPage extends StatefulWidget {
  static const routeName = '/ListPage';
  static String id = 'ListPage';

  @override
  _ListPageState createState() => _ListPageState();
}
class _ListPageState extends State<ListPage> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("posts").getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(post: post,)));
  }

  void initState() {
    super.initState();
    _data = getPosts();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar:  AppBar(
        title: Text("Details of employee"),
        backgroundColor: Colors.blue[900],
      ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
    onPressed: () {

    Navigator.push(context, new  MaterialPageRoute(builder: (context) => new AddContacts()));
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
                    title: Text(snapshot.data[index].data["title"]),
                    onTap: () =>
                       navigateToDetail(snapshot.data[index]),


                );
               });
    }
          },),

    ],),);


  }
}
class DetailPage extends StatefulWidget{
  final DocumentSnapshot post;
  DetailPage({this.post});
  @override
  _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
        title: Text(widget.post.data["title"]),
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
      body:Column(children: <Widget>[

        DataTable(
      horizontalMargin: 6.0,
      columnSpacing: 10.0,
      headingRowHeight: 32.0,
      dataRowHeight: 80.0,

    columns: [
      DataColumn(label: Text('Employee Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
    )),
      DataColumn(label:  Text(
          'Designation',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
      )),
      DataColumn(label: Text(
          'Salary',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
      )),
      DataColumn(label: Text(
          'Date of Join',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
      )),
      DataColumn(label: Text(
          'Qualification',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
      )),
    ],
      rows:[
    DataRow(
          cells: <DataCell>[

      DataCell(Text(widget.post.data["title" ]),),
    DataCell(Text(widget.post.data["content" ])),
    DataCell(Text(widget.post.data["Salary"] )),
    DataCell(Text(widget.post.data["JoinDate" ]  )),
    DataCell(Text(widget.post.data["Qualification"] ))
    ],)

         ],),
              ]));
    // ),);



  }
}