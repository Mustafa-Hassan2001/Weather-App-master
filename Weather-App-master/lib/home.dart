import 'package:flutter/material.dart';
import './const.dart' as cons ;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './next_screen.dart' as nextScreen;
class HomeForm extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeForm> {
  var _city = cons.defaultCity;

  Future _goToNextScreen(BuildContext context) async{
    Map result = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(builder: (BuildContext context){
        return new nextScreen.NextScreen();
      })
    );
    if(result != null && result.containsKey('city')){
      _city = result['city'].toString();
    }
    
  }

 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Lovely"),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.menu), onPressed:() {_goToNextScreen(context);}),
          ],
        ),
        body: new Stack(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                'images/umbrella.png',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),
            new Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
              child: new Text(
                '${ _city == null? cons.defaultCity : _city }',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontStyle: FontStyle.italic),
              ),
            ),
            new Container(
              alignment: Alignment.center,
                child: new Image.asset(
              'images/light_rain.png',
            )),
            new Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(30.0, 330.5, 0.0, 0.0),
                child: updateTemp(_city.toString()) )
          ],
        ));
  }

  Future<Map> getweather(String city,String appId) async{
    String url = 'https://samples.openweathermap.org/data/2.5/weather?q=$city&appid=$appId=imperial';
    http.Response req = await http.get(url);
    return json.decode(req.body);
  }

  Widget updateTemp(String city){
  return new FutureBuilder(
    future: getweather(city == null? cons.defaultCity:city , cons.apiId),
    builder: (BuildContext context,AsyncSnapshot<Map> snapshot){
      if(snapshot.hasData)
      {
        Map data = snapshot.data;
        return new Container(
          child: new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(
                  '${data['main']['temp'].toString()} F',
                  style:TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300) ,
                ),
                subtitle: new ListTile(
                  title: new Text(
                    "Pressure: ${data['main']['pressure'].toString()} F\n"
                    "Temp Min: ${data['main']['temp_min'].toString()} F\n"
                    "Temp Max: ${data['main']['temp_max'].toString()} F\n",
                    style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17.0,
                    fontStyle: FontStyle.normal),
                  ),
                ),
              )
            ],
          ),
        );
      }
      else{
        return new Container();
      }

    },
  );
}
}
 

