import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double _counter = 0.00;
  final myController = TextEditingController();
  final List<String> entries = [];
  final _formKey = GlobalKey<FormState>();

  void _add() {
    setState(() {
      double x = double.parse(myController.text);
      String result = "$_counter + $x = ";
      _counter+=x;
      result = result + "$_counter";
      entries.add(result);
      log('result: $result');
      log('List result: $entries');
    });
  }
  void _substract() {
    setState(() {
      double x = double.parse(myController.text);
      String result = "$_counter - $x = ";
      _counter-=x;
      result = result + "$_counter";
      entries.add(result);
      log('result: $result');
      log('List result: $entries');
    });
  }
  void _multiply() {
    setState(() {
      double x = double.parse(myController.text);
      String result = "$_counter * $x = ";
      _counter*=x;
      result = result + "$_counter";
      entries.add(result);
      log('result: $result');
      log('List result: $entries');
    });
  }
  void _divided() {
    setState(() {
      double x = double.parse(myController.text);
      String result = "$_counter / $x = ";
      _counter/=x;
      result = result + (_counter==double.infinity || _counter == double.negativeInfinity || _counter.isNaN
          ? "Error"
          :"$_counter");
      entries.add(result);
      log('result: $result');
      log('List result: $entries');
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
        child:Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  _counter == double.infinity || _counter == double.negativeInfinity || _counter.isNaN
                      ? 'Result : Error'
                      : 'Result : $_counter',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20),
                  controller: myController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)  return "please input number";
                    else if (double.tryParse(value) == null)  return "please input number";
                    else return null;
                   },
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        var reversedList = new List.from(entries.reversed);
                        return Text(reversedList[index]);
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate())
                        {
                          _add();
                        }
                        },
                      color: Colors.blue,
                      child: Text('+', style: TextStyle(color: Colors.white),),
                    ),
                    RaisedButton(
                      onPressed: (){
                      if (_formKey.currentState!.validate())
                      {
                        _substract();
                      }
                      },
                      color: Colors.blue,
                      child: Text('-', style: TextStyle(color: Colors.white),),
                    ),
                    RaisedButton(
                      onPressed:  (){
                      if (_formKey.currentState!.validate())
                      {
                        _multiply();
                      }
                      },
                      color: Colors.blue,
                      child: Text('x', style: TextStyle(color: Colors.white),),
                    ),
                    RaisedButton(
                      onPressed: (){
                      if (_formKey.currentState!.validate())
                      {
                        _divided();
                      }
                      },
                      color: Colors.blue,
                      child: Text('/', style: TextStyle(color: Colors.white),),
                    ),
                    RaisedButton(
                      onPressed: (){
                        this.setState(() {
                          myController.clear();
                          _counter = 0;
                          entries.clear();
                        });
                      },
                      color: Colors.redAccent,
                      child: Text('AC', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }


}
