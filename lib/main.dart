import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilderAPP(),
    );
  }
}

class StreamBuilderAPP extends StatefulWidget {
  @override
  _StreamBuilderAPPState createState() => _StreamBuilderAPPState();
}

class _StreamBuilderAPPState extends State<StreamBuilderAPP> {
  final StreamController<Color> colorStream = StreamController<Color>();
  int _counter = -1;
  final List<Color> colorList = [Colors.blue, Colors.yellow, Colors.green];

  @override
  void dispose() {
    colorStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: colorStream.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return LoadingWidget();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Text("Stream ended");
            }
            return Container(
              height: 150,
              width: 150,
              color: snapshot.data,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.color_lens),
        onPressed: () {
          _counter++;
          if (_counter < colorList.length) {
            colorStream.sink.add(colorList[_counter]);
          } else {
            colorStream.close();
          }
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Waiting for data"),
        SizedBox(height: 16),
        CircularProgressIndicator(),
      ],
    );
  }
}
