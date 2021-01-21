import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pass_formula.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {

  // Create storage
  final storage = new FlutterSecureStorage();

  String password = '';
  String username = '';

  final lengthController = TextEditingController();

  bool upperCase = false;
  bool lowerCase = false;
  bool haveNumbers = false;
  bool specialChars = false;

  int length = 20;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    lengthController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('Add ID',
              style: TextStyle(fontWeight: FontWeight.bold,
                  height: 2, fontSize: 30,
                  fontFamily: 'Arial Black'),
            ),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(10.0)
                ),
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Type your user Id',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1.0
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1.0
                                  )
                              )
                          ),
                          onChanged: (value){
                            username = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: password.length>0 ? password : 'Your Password',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1.0
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1.0
                                  )
                              ),
                          ),
                          readOnly: true,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RaisedButton(
                              onPressed: (){
                                Clipboard.setData(new ClipboardData(text: password));
                                Alert(
                                  context: context,
                                  title: 'Copied!',
                                  desc: 'Your password has been copied to clipboard.',
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Done",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      width: 120,
                                    )
                                  ],
                                ).show();
                              },
                              color: Colors.blue[700],
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Copy',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                        Icons.copy,
                                        color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.blue[700],
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () async{
                                // Write value
                                print(username);
                                await storage.write(key: username.toString(), value: password.toString());
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(10.0)
                ),
                margin: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Length',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          length.toString(),
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    Slider(
                        value: length.toDouble(),
                        max: 100,
                        min: 20,
                        activeColor: Colors.white,
                        inactiveColor: Colors.grey,
                        onChanged: (double newValue){
                          setState(() {
                            length = newValue.round();
                          });
                        })
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text('Uppercase',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                ),
                                flex: 4,
                              ),
                              Expanded(
                                child: Checkbox(
                                    value: upperCase,
                                    onChanged: (bool value){
                                      setState(() {
                                        upperCase = value;
                                      });
                                    }
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text('Lowercase',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                ),
                                flex: 4,
                              ),
                              Expanded(
                                child: Checkbox(
                                    value: lowerCase,
                                    onChanged: (bool value){
                                      setState(() {
                                        lowerCase = value;
                                      });
                                    }
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text('Numbers',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                ),
                                flex: 4,
                              ),
                              Expanded(
                                child: Checkbox(
                                    value: haveNumbers,
                                    onChanged: (bool value){
                                      setState(() {
                                        haveNumbers = value;
                                      });
                                    }
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text('Special characters',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                ),
                                flex: 4,
                              ),
                              Expanded(
                                child: Checkbox(
                                    value: specialChars,
                                    onChanged: (bool value){
                                      setState(() {
                                        specialChars = value;
                                      });
                                    }
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            RaisedButton(
              onPressed: (){
                setState(() {
                  String result = PassFormula(upperCase, lowerCase, haveNumbers, specialChars).generatePassword(length);
                  password = result;
                });//Updating the password textField
              },
              color: Colors.blue[700],
              padding: EdgeInsets.all(20),
              child: Text(
                'Generate Password',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
