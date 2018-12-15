import 'package:flutter/material.dart';

import 'package:awareframework_screen/awareframework_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ScreenSensor sensor;
  ScreenSensorConfig config;

  @override
  void initState() {
    super.initState();

    config = ScreenSensorConfig()
      ..debug = true;

    sensor = new ScreenSensor.init(config);

    sensor.start();

  }

  @override
  Widget build(BuildContext context) {


    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Plugin Example App'),
          ),
          body: new ScreenCard(sensor: sensor,)
      ),
    );
  }
}
