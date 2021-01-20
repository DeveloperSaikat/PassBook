import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'pass_gen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> username = [];
  List<String> password = [];

  void storageValues() async{
    Map<String, String> allValues = await storage.readAll();
    for(String i in allValues.keys){
      username.add(i);
      password.add(allValues[i]);
    }
  }

  List<Card> getAllCards(){
    List<Card> allCards = [];
    for(int i = 0; i < username.length; i++){
      var newCard = Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username[i],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
              Text(
                  password[i]
              )
            ],
          ),
        ),
      );
      allCards.add(newCard);
    }

    return allCards;
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    storageValues();
    print('In here');
  }

  final storage = new FlutterSecureStorage();

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('In Deactivate');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Screen',
            style: TextStyle(fontWeight: FontWeight.bold,
                height: 2, fontSize: 30,
                fontFamily: 'Arial Black'),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: getAllCards()
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return PasswordGenerator();
            }));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
