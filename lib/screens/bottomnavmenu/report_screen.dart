// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_scale/provider/CounterProvider.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // int _counter = 0;

  // void _counterUp(){
  //   setState(() {
  //     _counter++;
  //   });
  // }

  // void _counterDown(){
  //   setState(() {
  //     _counter--;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Time Stamp ${DateTime.now().microsecondsSinceEpoch}',
            style: TextStyle(fontSize: 20.0)),
        SizedBox(
          height: 20,
        ),
        Consumer<CounterProvider>(
          builder: ((context, counter, child) => Column(
                children: [
                  ElevatedButton(
                    onPressed: () => counter.counterUp(),
                    child: Text("Counter +"),
                  ),
                  Text(
                    counter.getCounter.toString(),
                    style: TextStyle(fontSize: 100.0),
                  ),
                  ElevatedButton(
                    onPressed: () => counter.counterDown(),
                    child: Text("Counter -"),
                  ),
                ],
              )),
        )
      ]),
    );
  }
}
