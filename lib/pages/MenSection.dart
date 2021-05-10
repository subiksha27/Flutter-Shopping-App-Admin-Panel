import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class MenSection extends StatefulWidget {
  static const routeName = '/MenSection';
  static String id = 'MenSection';

  @override
  _MenSectionState createState() => _MenSectionState();
}
class  _MenSectionState extends State<MenSection> {

  _MenSectionState({this.auth, this.onSignedOut});
  final auth; //BaseAuth
  final VoidCallback onSignedOut;
  Future _data;

  void _signOut () async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print (e);
    }
  }
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("mensection").getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Pages(post: post,)));
  }

  void initState() {
    super.initState();
    _data = getPosts();
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text ('Men Section'),
            backgroundColor: Colors.blue[900],

            actions: <Widget>[

              //new FlatButton(
              //child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              //onPressed: _signOut
              //)
            ]
        ),
        body: new StreamBuilder(
          stream: Firestore.instance.collection('mensection').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return new Column(//GridView.count(
              //crossAxisCount: 2,
              //childAspectRatio: 1.0,
              // padding: const EdgeInsets.all(4.0),
              //mainAxisSpacing: 4.0,
              //crossAxisSpacing: 4.0,


              children:<Widget>[// snapshot.data.documents.map((DocumentSnapshot document) {

                FutureBuilder(

                    future:_data,
                    builder: (_,snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading...."),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              return ListTile(

                                title: new  Text(snapshot.data[index].data["quality"]),//Text(document['orders']),
                                subtitle: new Text(snapshot.data[index].data["cloth"]),
                                onTap: () =>
                                    navigateToDetail(snapshot.data[index]),
                              );
                            }

                        );
                      }
                    } ), ],);
          },
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: new Color(0xFFE57373),
            onPressed: (){
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new UploadFormField()),
              );

            }
        )
    );
  }

}



// UPLOAD TO FIRESTORE



class UploadFormField extends StatefulWidget {
  @override
  _UploadFormFieldState createState() => _UploadFormFieldState();
}

class _UploadFormFieldState extends State<UploadFormField> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  String quality,cloth,quantity,pricerange,manufacturers,others;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Upload'),
          backgroundColor: Colors.blue[900],
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: FormUI(),

            ),
          ),
        ),
      ),
    );
  }
  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.check_circle_outline_sharp),hintText: 'Quality'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
              quality = val;
            }
        ),


        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.category_sharp),hintText: 'Cloth types available'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
              cloth = val;
            }
        ),

        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.equalizer_outlined),hintText: 'Quantity'),cursorColor: Colors.pinkAccent,
            // validator: validateshippingstatus,
            onSaved: (String val) {
              quantity = val;
            }
        ),
        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.payments),hintText: 'Price Range'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
              pricerange = val;
            }
        ),
        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.precision_manufacturing_sharp),hintText: 'Manufacturers'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
              manufacturers = val;
            }
        ),
        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.wallet_travel_sharp),hintText: 'Brands Available'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
             others= val;
            }
        ),





        new SizedBox(height: 15.0),
        new RaisedButton(onPressed: _sendToServer,color: Colors.blue[900], child: new Text('Upload',style: TextStyle(color: Colors.white))



        ),],
    );
  }
  String validateorder(String value) {
    String patttern = r'(^[a-zA-Z ][0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Order is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Order must be a-z and A-Z or 0-9";
    }
    return null;
  }

  String validateshippingstatus(String value) {
    String patttern = r'(^[a-zA-Z ][0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Transaction status is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Transaction status must be a-z, A-Z or 0-9";
    }
    return null;
  }


  _sendToServer(){
    if (_key.currentState.validate() ){
      //No error in validator
      _key.currentState.save();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection('mensection');

        await reference.add({"quality":"$quality","cloth": "$cloth", "quantity": "$quantity","pricerange":"$pricerange","manufacturers":"$manufacturers","others":"$others"});
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }

  }
}

class Pages extends StatefulWidget{
  final DocumentSnapshot post;
  Pages({this.post});
  @override
  _StatusState createState() => _StatusState();
}
class _StatusState extends State<Pages>{
  Widget build(BuildContext context){
    return Scaffold(
        appBar:  AppBar(
          title: Text("Men Section  Details"),
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

                    label:Text("Quality"),),

                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[

                      DataCell(Text(widget.post.data['quality']),),

                      //, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),),
                      // DataColumn(label: Text('Total-price-of-Stock', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),//, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),),

                    ],),

                ],
              ),

              DataTable(
                horizontalMargin: 6.0,
                columnSpacing: 8.0,
                headingRowHeight: 32.0,
                dataRowHeight: 80.0,
                columns:[
                  DataColumn(

                    label:Text("Cloth Varieties"),),

                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[

                      DataCell(Text(widget.post.data['cloth']),),

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
                      label:Text("Quantity(Stock)"),),],
                  rows: [
                    DataRow(
                        cells: <DataCell>[  DataCell(Text(widget.post.data['quantity']),)]),]),
              DataTable(

                  horizontalMargin: 6.0,
                  columnSpacing: 15.0,
                  headingRowHeight: 32.0,
                  dataRowHeight: 80.0,

                  columns:[
                    DataColumn(
                      label:Text("Price Range"),),],
                  rows: [
                    DataRow(
                        cells: <DataCell>[  DataCell(Text(widget.post.data['pricerange']),)]),]),


              DataTable(

                horizontalMargin: 6.0,
                columnSpacing: 15.0,
                headingRowHeight: 32.0,
                dataRowHeight: 80.0,

                columns:[ DataColumn(
                  label:Text("Manufacturers"),),],
                rows: [
                  DataRow(
                      cells: <DataCell>[  DataCell( Text(widget.post.data['manufacturers']),),]),],),

              DataTable(

                horizontalMargin: 6.0,
                columnSpacing: 15.0,
                headingRowHeight: 32.0,
                dataRowHeight: 80.0,

                columns:[ DataColumn(
                  label:Text("Brands Available"),),],
                rows: [
                  DataRow(
                      cells: <DataCell>[  DataCell( Text(widget.post.data['others']),),]),],),



            ])


    );


  }
}
