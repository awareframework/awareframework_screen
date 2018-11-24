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
  static const EventChannel  _screenUncloknStream  = const EventChannel('awareframework_screen/event_on_screen_unlock');


  /// Init Screen Sensor with ScreenSensorConfig
  ScreenSensor(ScreenSensorConfig config):this.convenience(config);
  ScreenSensor.convenience(config) : super(config){
    /// Set sensor method & event channels
    super.setMethodChannel(_screenMethod);
  }

  Stream<dynamic> onScreenOn(String id) {
    return super.getBroadcastStream(_screenOnStream, "on_screen_on", id);
  }

  Stream<dynamic> onScreenOff(String id) {
    return super.getBroadcastStream(_screenOffStream, "on_screen_off", id);
  }

  Stream<dynamic> onScreenLocked(String id) {
    return super.getBroadcastStream(_screenLockStream, "on_screen_locked", id);
  }

  Stream<dynamic> onScreenUnlocked(String id){
    return super.getBroadcastStream(_screenUncloknStream, "on_screen_unlocked", id);
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
  ScreenCard({Key key, @required this.sensor, this.cardId = "screen_card_id"}) : super(key: key);

  ScreenSensor sensor;
  String cardId;

  @override
  ScreenCardState createState() => new ScreenCardState();
}


class ScreenCardState extends State<ScreenCard> {

  String data = "Unknown";
  @override
  void initState() {

    super.initState();
    // set observer
    widget.sensor.onScreenOn(widget.cardId+"_on").listen((event) {
      setState((){
        data = "On";
      });
    });

    widget.sensor.onScreenOff(widget.cardId+"_off").listen((event) {
      setState((){
        data = "Off";
      });
    });

    widget.sensor.onScreenLocked(widget.cardId+"_lock").listen((event) {
      setState((){
        data = "Locked";
        print("lock");
      });
    });

    widget.sensor.onScreenUnlocked(widget.cardId+"_unlock").listen((event) {
      setState((){
        data = "Unlocked";
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
          child: new Text("Screen: $data"),
        ),
      title: "Screen",
      sensor: widget.sensor
    );
  }

  @override
  void dispose() {
    widget.sensor.cancelBroadcastStream(widget.cardId+"_on");
    widget.sensor.cancelBroadcastStream(widget.cardId+"_off");
    widget.sensor.cancelBroadcastStream(widget.cardId+"_lock");
    widget.sensor.cancelBroadcastStream(widget.cardId+"_unlock");
    super.dispose();
  }

}
