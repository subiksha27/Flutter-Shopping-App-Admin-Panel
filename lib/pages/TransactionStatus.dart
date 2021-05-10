import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class TransactionStatus extends StatefulWidget {
  static const routeName = '/TransactionStatus';
  static String id = 'TransactionStatus';

  @override
  _TransactionStatusState createState() => _TransactionStatusState();
}
class  _TransactionStatusState extends State<TransactionStatus> {

  _TransactionStatusState({this.auth, this.onSignedOut});
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
    QuerySnapshot qn = await firestore.collection("transactions").getDocuments();
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
            title: new Text ('Transaction and pending payments'),
            backgroundColor: Colors.blue[900],

            actions: <Widget>[

              //new FlatButton(
                  //child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                  //onPressed: _signOut
              //)
            ]
        ),
        body: new StreamBuilder(
          stream: Firestore.instance.collection('transactions').snapshots(),
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

                            title: new  Text(snapshot.data[index].data["billnumber"]),//Text(document['orders']),
                            subtitle: new Text(snapshot.data[index].data["shipping(status)"]),
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
  String orders, shippingstatus,payment,transactionmode,billnumber;

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
            decoration: new InputDecoration(icon:Icon(Icons.format_list_numbered),hintText: 'Bill Number'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
             billnumber = val;
            }
        ),


        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.shopping_cart),hintText: 'Orders'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
              orders = val;
            }
        ),

        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.emoji_transportation_sharp),hintText: 'Shipping(status)'),cursorColor: Colors.pinkAccent,
           // validator: validateshippingstatus,
            onSaved: (String val) {
              shippingstatus = val;
            }
        ),
        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.monetization_on_rounded),hintText: 'Payment'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
              payment = val;
            }
        ),
        new TextFormField(
            decoration: new InputDecoration(icon:Icon(Icons.payments_sharp),hintText: 'Mode Of Transaction'),cursorColor: Colors.pinkAccent,
            //validator: validateorder,
            onSaved: (String val) {
              transactionmode = val;
            }
        ),



        new SizedBox(height: 15.0),
        new RaisedButton(onPressed: _sendToServer,color: Colors.blue[900], child: new Text('Upload',style: TextStyle(color: Colors.white))



        ),],
    );
  }


  _sendToServer(){
    if (_key.currentState.validate() ){
      //No error in validator
      _key.currentState.save();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection('transactions');

        await reference.add({"billnumber":"$billnumber","orders": "$orders", "shipping(status)": "$shippingstatus","payment":"$payment","transaction(mode)":"$transactionmode"});
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
          title: Text("Payment Details"),
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

                    label:Text("Bill Number"),),

                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[

                      DataCell(Text(widget.post.data['billnumber']),),

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

                    label:Text("Orders"),),

                ],
                rows: [
                  DataRow(
                    cells: <DataCell>[

                      DataCell(Text(widget.post.data['orders']),),

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
                      label:Text("Shipping - Status"),),],
                  rows: [
                    DataRow(
                        cells: <DataCell>[  DataCell(Text(widget.post.data['shipping(status)']),)]),]),
              DataTable(

                  horizontalMargin: 6.0,
                  columnSpacing: 15.0,
                  headingRowHeight: 32.0,
                  dataRowHeight: 80.0,

                  columns:[
                    DataColumn(
                      label:Text("Payment"),),],
                  rows: [
                    DataRow(
                        cells: <DataCell>[  DataCell(Text(widget.post.data['payment']),)]),]),


              DataTable(

                horizontalMargin: 6.0,
                columnSpacing: 15.0,
                headingRowHeight: 32.0,
                dataRowHeight: 80.0,

                columns:[ DataColumn(
                  label:Text("Mode of transaction"),),],
                rows: [
                  DataRow(
                      cells: <DataCell>[  DataCell( Text(widget.post.data['transaction(mode)']),),]),],),


            ])


        );


  }
}
