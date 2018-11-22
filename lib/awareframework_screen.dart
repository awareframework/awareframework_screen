import 'dart:async';

import 'package:flutter/services.dart';
import 'package:awareframework_core/awareframework_core.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// init sensor
class ScreenSensor extends AwareSensorCore {
  static const MethodChannel _screenMethod = const MethodChannel('awareframework_screen/method');
  static const EventChannel  _screenStream  = const EventChannel('awareframework_screen/event');

  /// Init Screen Sensor with ScreenSensorConfig
  ScreenSensor(ScreenSensorConfig config):this.convenience(config);
  ScreenSensor.convenience(config) : super(config){
    /// Set sensor method & event channels
    super.setSensorChannels(_screenMethod, _screenStream);
  }

  Stream<dynamic> get onScreenOn {
    return super.receiveBroadcastStream("on_screen_on");
  }

  Stream<dynamic> get onScreenOff {
    return super.receiveBroadcastStream("on_screen_off");
  }

  Stream<dynamic> get onScreenLocked {
    return super.receiveBroadcastStream("on_screen_locked");
  }

  Stream<dynamic> get onScreenUnlocked{
    return super.receiveBroadcastStream("on_screen_unlocked");
  }
}

class ScreenSensorConfig extends AwareSensorConfig{
  ScreenSensorConfig();
  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    return map;
  }
}

/// Make an AwareWidget
class ScreenCard extends StatefulWidget {
  ScreenCard({Key key, @required this.sensor}) : super(key: key);

  ScreenSensor sensor;

  @override
  ScreenCardState createState() => new ScreenCardState();
}


class ScreenCardState extends State<ScreenCard> {

  String data = "event: unknown";
  @override
  void initState() {

    super.initState();
    // set observer
    widget.sensor.onScreenOn.listen((event) {
      setState((){
        data = "event: screen on";
      });
    });

    widget.sensor.onScreenOff.listen((event) {
      setState((){
        data = "event: screen off";
      });
    });

    widget.sensor.onScreenLocked.listen((event) {
      setState((){
        data = "event: screen locked";
      });
    });

    widget.sensor.onScreenUnlocked.listen((event) {
      setState((){
        data = "event: screen unlocked";
      });
    });

    print(widget.sensor);
  }


  @override
  Widget build(BuildContext context) {
    return new AwareCard(
      contentWidget: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: new Text(data),
        ),
      title: "Screen",
      sensor: widget.sensor
    );
  }

}
