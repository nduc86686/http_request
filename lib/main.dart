import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http_request/network/data_inf.dart';

import 'model/Data.dart';
import 'network/request_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements DataInf{
  int _counter = 0;
  HttpService ?http;
  List<Data>? data;
  @override
  void initState() {
    log('runn');
    http=HttpService(context,this);
    super.initState();

  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          child: ListView.builder(
            itemCount: data?.length,
            itemBuilder: (context,int){
              return Container(
                child: Text('${data?[int].title}'),
              );
            },
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
        await  http?.postData(title: 'titel',userId: 1,bodys: 'body');
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void getData(List<Data> d) {
    if(d!=null){
      setState(() {
        data=d;
      });
    }
  }
}
