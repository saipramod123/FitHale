import 'package:flutter/material.dart';
import 'package:travel_budget/pages.dart';
import 'profile_view.dart';
import 'navigation_view2.dart';
import 'package:travel_budget/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {
  final User user;
  Home({Key key, @required this.user,}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  //int _currentIndex = 0;
  int radioValue = -1;
  String _textResult = '';
  void _handleRadioValueChange1(int value){
    setState(() {
      radioValue = value;
      switch (radioValue)
      {
        case 0:
          _textResult='Male';
          break;
        case 1:
          _textResult='Female';
          break;
        case 2:
          _textResult='Other';
              break;
      }
      print(_textResult);
      widget.user.gender=_textResult;
    });
  }


  final List<Widget> _children = [
  //  HomeView(),
    ExplorePage(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    final db = Firestore.instance;
    //initializing
    //final newUser = new User(null,null,null,null,null);
    TextEditingController _titleController1 = new TextEditingController();
    TextEditingController _titleController2 = new TextEditingController();
    TextEditingController _titleController3 = new TextEditingController();
    _titleController1.text = widget.user.age;
    _titleController2.text = widget.user.height;
    _titleController3.text = widget.user.weight;


    return new Scaffold(
      appBar: new AppBar(
        title: new Text('FitHale'),
      ),
      body: new SafeArea(
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child:new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(7.0),
                  ),
                  new Text(
                    'Tell us more about you',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),
                  ),
                  new Text(
                    'We need this information to customize your experience',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  new TextFormField(
                    controller: _titleController1,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Age ',
                      labelText: 'Age',
                    ),
                  ),
                  new TextFormField(
                    controller: _titleController2,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your height',
                      labelText: 'Height',
                    ),
                  ),
                  new TextFormField(
                    controller: _titleController3,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your weight',
                      labelText: 'Weight',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                  ),
                  new Row(
                      children: <Widget>[
                        new Text(
                          "Gender:",
                          style: TextStyle(color: Colors.black54,fontSize: 17.0),
                        ),
                        new Radio(
                          value: 0,
                          groupValue: radioValue,
                          onChanged: _handleRadioValueChange1,
                        ),
                        new Text(
                          'Male',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: radioValue,
                          onChanged: _handleRadioValueChange1,
                        ),
                        new Text(
                          'Female',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 2,
                          groupValue: radioValue,
                          onChanged: _handleRadioValueChange1,
                        ),
                        new Text(
                          'Other',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ]),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                      child: new RaisedButton(
                          child: const Text('Next'),
                         onPressed: () async{
                           //String userId = (await FirebaseAuth.instance.currentUser()).uid;
                            widget.user.age = _titleController1.text;
                            widget.user.height= _titleController2.text;
                            widget.user.weight= _titleController3.text;
                           //save data to firebase
                           //await db.collection("users").add(widget.user.toJson());
                           /* FirebaseAuth.instance.currentUser().then((currentUser) => Firestore.instance.collection('users').document(currentUser.uid).setData(
                                {'email': widget.user.email, 'displayName': widget.user.name, 'age': widget.user.age, 'height': widget.user.height, 'weight':  widget.user.weight, 'Gender':_textResult}).then((onValue) {
                            }));*/
                            /*Firestore.instance.collection('users').document(userId).setData(
                                {'age': newUser.age, 'height': newUser.height, 'weight':  newUser.weight}).then((onValue) {
                            });*/
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Screen3(user: widget.user)),
                           );
                          }
                      )),

                ],
              )
          )
      ),
    );
  }
}

