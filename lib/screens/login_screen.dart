import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';
import 'package:flutter_app1/widgets/CurvedWidget.dart';
import 'home_screen.dart';
import 'signup_screen.dart';



class LoginScreen extends StatefulWidget {

  static const routeName = '/login';
  static String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email' : '',
    'password': ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _submit() async
  {
    if(!_formKey.currentState.validate())
    {
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).logIn(
          _authData['email'],
          _authData['password']
      );

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    } catch (error)
    {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Image.asset('images/logo.jpg', fit: BoxFit.contain,height: 55,width: 55,
            alignment: FractionalOffset.center),
        backgroundColor:Colors.purple[100],
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Signup'),
                Icon(Icons.person_add)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
            },
          )
        ],
      ),
    body: SingleChildScrollView(
    child: Stack(
        children: <Widget>[CurvedWidget(
          child:Container(

            height: 7100,//double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple[100], Colors.pinkAccent],
                )),


          ),

        ),
   //child: SingleChildScrollView(
    //child: Stack(
    //children: <Widget>[
    CurvedWidget(


    child: Container(
       padding: const EdgeInsets.only(top:50,left:50),

      width: 1000,//double.infinity,
      height: 250,

            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
    end:Alignment.bottomCenter,
                colors: [Colors.purple[50], Colors.white.withOpacity(0.5)],
    //colors: <Color>[Colors.black,Colors.blue[700]],

                //image: new AssetImage('images/logo.jpg'),
                //fit: BoxFit.cover,
                //colorFilter:ColorFilter.mode(Colors.black45,BlendMode.darken),
              ),
    ),


      child: Text('Login',style: TextStyle(
        fontSize: 40,
        color: Colors.purpleAccent,
      ),),

            ),),
          Form(
            //child: Card(
              //shape: RoundedRectangleBorder(
                //borderRadius: BorderRadius.circular(10.0),
              //),
              child: Container(
                height: 300,
                width: 300,
                margin: const EdgeInsets.only(top: 150),
                padding: EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //email
                        TextFormField(
                          decoration: InputDecoration(icon: Icon(Icons.email),labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty || !value.contains('@'))
                            {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['email'] = value;
                          },
                        ),

                        //password
                        TextFormField(
                          decoration: InputDecoration(icon: Icon(Icons.lock),labelText: 'Password'),
                          obscureText: true,
                          validator: (value)
                          {
                            if(value.isEmpty || value.length<=5)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['password'] = value;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text(
                              'Submit'
                          ),
                          onPressed: ()
                          {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.purpleAccent,
                          textColor: Colors.white,
                        ),
                       //RaisedButton(
                         // child: Text(
                           //   'Signup',style: TextStyle(
                            //color: Colors.white,
                        //)),


                         //shape: RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(30),),
                         //color: Colors.purpleAccent,
                         // textColor: Colors.white,

                          //onPressed: (){
                            //Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
                          //},
                        //)



                      ],
                    ),
                  ),
                ),
              ),
            ),
         // )
        ],
      ),
    ));
  }
}
