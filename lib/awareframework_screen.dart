import 'dart:async';

import 'package:flutter/services.dart';
import 'package:awareframework_core/awareframework_core.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// init sensor
class ScreenSensor extends AwareSensorCore {
  static const MethodChannel _screenMethod = const MethodChannel('awareframework_screen/method');
  static const EventChannel  _screenStream  = const EventChannel('awareframework_screen/event');

  static const EventChannel  _screenOnStream  = const EventChannel('awareframework_screen/event_on_screen_on');
  static const EventChannel  _screenOffStream  = const EventChannel('awareframework_screen/event_on_screen_off');
  static const EventChannel  _screenLockStream  = const EventChannel('awareframework_screen/event_on_screen_lock');
  static const EventChannel  _screenUnlockStream  = const EventChannel('awareframework_screen/event_on_screen_unlock');


  /// Init Screen Sensor with ScreenSensorConfig
  ScreenSensor(ScreenSensorConfig config):this.convenience(config);
  ScreenSensor.convenience(config) : super(config){
    super.setMethodChannel(_screenMethod);
  }

  Stream<dynamic> get onScreenOn {
    return super.getBroadcastStream(_screenOnStream, "on_screen_on");
  }

  Stream<dynamic> get onScreenOff {
    return super.getBroadcastStream(_screenOffStream, "on_screen_off");
  }

  Stream<dynamic> get onScreenLocked {
    return super.getBroadcastStream(_screenLockStream, "on_screen_locked");
  }

  Stream<dynamic> get onScreenUnlocked{
    return super.getBroadcastStream(_screenUnlockStream, "on_screen_unlocked");
  }

  @override
  void cancelAllEventChannels() {
    super.cancelBroadcastStream("on_screen_on");
    super.cancelBroadcastStream("on_screen_off");
    super.cancelBroadcastStream("on_screen_locked");
    super.cancelBroadcastStream("on_screen_unlocked");
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

  final ScreenSensor sensor;

  String data = "Unknown";

  @override
  ScreenCardState createState() => new ScreenCardState();
}


class ScreenCardState extends State<ScreenCard> {

  @override
  void initState() {

    super.initState();
    // set observer
    widget.sensor.onScreenOn.listen((event) {
      setState((){
        widget.data = "On";
      });
    });

    widget.sensor.onScreenOff.listen((event) {
      setState((){
        widget.data = "Off";
      });
    });

    widget.sensor.onScreenLocked.listen((event) {
      setState((){
        widget.data = "Locked";
        print("lock");
      });
    });

    widget.sensor.onScreenUnlocked.listen((event) {
      setState((){
        widget.data = "Unlocked";
        print("unlock");
      });
    });

    print(widget.sensor);
  }


  @override
  Widget build(BuildContext context) {
    return new AwareCard(
      contentWidget: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: new Text("Screen: ${widget.data}"),
        ),
      title: "Screen",
      sensor: widget.sensor
    );
  }

  @override
  void dispose() {
    widget.sensor.cancelAllEventChannels();
    super.dispose();
  }

}
