import 'package:flutter/material.dart';

class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  var _cityConroll = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Change City"),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          
        ),
        body: new Stack(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                'images/white_snow.png',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),
            new Column(
              children: <Widget>[
                new TextField(
              decoration: new InputDecoration(
                hintText: "Enter City",
              ),
              keyboardType: TextInputType.text,
              controller: _cityConroll,
            ),
            new FlatButton(onPressed: (){
              Navigator.pop(context,{
                'city': _cityConroll.text
              });
            },
             child: new Text("Get Weather"),
             textColor: Colors.white,
             color: Colors.redAccent,
             )
              ],
            )
            
          ]   
        ));
  }
}