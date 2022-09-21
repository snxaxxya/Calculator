import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_app/calculator/calculator_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: BlocProvider<CalculatorBloc>(
        create: (context) => CalculatorBloc(),
        child: MyHomePage(title: 'Calculator'),
      )
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

  final inputController = TextEditingController();
  final List<String> results = [];
  final _formKey = GlobalKey<FormState>();

  void _add() {
    BlocProvider.of<CalculatorBloc>(context).add(AddEvent(num.parse(inputController.text)));
  }
  void _substract() {
      BlocProvider.of<CalculatorBloc>(context).add(SubstractEvent(num.parse(inputController.text)));
  }
  void _multiply() {
    BlocProvider.of<CalculatorBloc>(context).add(MultiplyEvent(num.parse(inputController.text)));
  }
  void _divided() {
    BlocProvider.of<CalculatorBloc>(context).add(DevidedEvent(num.parse(inputController.text)));
  }
  void _clearAll(){
    BlocProvider.of<CalculatorBloc>(context).add(ClearEvent(num.parse(inputController.text)));
    inputController.clear();
  }

  @override
  void dispose() {
    inputController.dispose();
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
                BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state){
                    return Text(
                      state.result == double.infinity || state.result == double.negativeInfinity || state.result.isNaN
                          ? 'Result : Error'
                          : 'Result : ${state.result}',
                      style: TextStyle(fontSize: 20),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 20),
                  controller: inputController,
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
                    child: BlocBuilder<CalculatorBloc,CalculatorState>(
                      builder: (context , state){
                        return ListView.builder(
                            itemCount: state.listHistory.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(state.listHistory[index]);
                            });
                      },
                    ),
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
                        _clearAll();
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
