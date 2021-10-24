import 'package:flutter/material.dart';

import 'package:awareframework_screen/awareframework_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  late ScreenSensor sensor;
  late ScreenSensorConfig config;

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    widget.config = ScreenSensorConfig();
    widget.config.debug = true;
    widget.sensor = new ScreenSensor.init(widget.config);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin Example App'),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  print("start");
                  widget.sensor.stop();
                  widget.sensor.start();
                  widget.sensor.onScreenLocked.listen((event) {
                    print("lock");
                  });
                },
                child: Text("Start")),
            TextButton(
                onPressed: () {
                  print("stop");
                  widget.sensor.stop();
                },
                child: Text("Stop")),
            TextButton(
                onPressed: () {
                  print("sync");
                  widget.sensor.sync();
                },
                child: Text("Sync")),
          ],
        ),
      ),
    );
  }
}
