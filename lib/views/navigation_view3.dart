import 'package:flutter/material.dart';
import 'navigation_view3.dart';
import 'package:travel_budget/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'first_view.dart';

class Screen4 extends StatelessWidget {
  final User user;
  Screen4({Key key, @required this.user,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Multiple Checkbox Example"),
          ),
          body: SafeArea(
              child : Center(
                child:CheckboxWidget(user:user),
              )
          )
      ),
    );
  }
}

class CheckboxWidget extends StatefulWidget{
  final User user;
  CheckboxWidget({Key key, @required this.user,}) : super(key: key);
  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

class CheckboxWidgetState extends State<CheckboxWidget> {

  Map<String, bool> values = {
    'Milk': false,
    'Egg': false,
    'Tree Nuts': false,
    'Peanuts': false,
    'Shellfish': false,
    'Wheat': false,
    'Soy': false,
    'Fish': false,
  };

  var tmpArray=[];
  getCheckboxItems(){

    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });
    widget.user.foods=tmpArray;

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    //tmpArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController1 = new TextEditingController();
    _titleController1.text = widget.user.ofoods;

    return Column (children: <Widget>[

      RaisedButton(
        child: Text("Tick the food items you would like to avoid", style: TextStyle(fontSize: 18),),
        onPressed: getCheckboxItems,
        color: Colors.blueAccent,
        textColor: Colors.white,
        splashColor: Colors.grey,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
      Expanded(
        child : ListView(
          children: values.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: values[key],
              activeColor: Colors.blueAccent,
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  values[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
      Expanded(
          child: new Form(
              child: new ListView(
                  children: <Widget>[
                    new TextFormField(
                      controller: _titleController1,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Specify if any',
                        labelText: 'Others',
                      ),
                    ),
                    new Container(
                        padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                        child: new RaisedButton(
                            child: const Text('Next'),
                            onPressed: ()async {
                              widget.user.ofoods=_titleController1.text;
                              getCheckboxItems();
                              FirebaseAuth.instance.currentUser().then((currentUser) => Firestore.instance.collection('users').document(currentUser.uid).setData(
                                  {'email': widget.user.email, 'displayName': widget.user.name, 'age': widget.user.age, 'height': widget.user.height, 'weight':  widget.user.weight, 'Gender': widget.user.gender, 'Health Problems': widget.user.health, 'Other Health Problems': widget.user.ohealth,'Food Allergies': widget.user.foods,'other Food Allergies': widget.user.ofoods }).then((onValue) {
                              }));
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    FirstView()),
                              );
                            }
                        )),


                  ]

              )
          )

      )]);
  }
}