import 'dart:async';

import 'package:flutter/services.dart';
import 'package:awareframework_core/awareframework_core.dart';
import 'package:flutter/material.dart';


/// The Screen measures the acceleration applied to the sensor
/// built-in into the device, including the force of gravity.
///
/// Your can initialize this class by the following code.
/// ```dart
/// var sensor = ScreenSensor();
/// ```
///
/// If you need to initialize the sensor with configurations,
/// you can use the following code instead of the above code.
/// ```dart
/// var config =  ScreenSensorConfig();
/// config
///   ..debug = true
///   ..frequency = 100;
///
/// var sensor = ScreenSensor.init(config);
/// ```
///
/// Each sub class of AwareSensor provides the following method for controlling
/// the sensor:
/// - `start()`
/// - `stop()`
/// - `enable()`
/// - `disable()`
/// - `sync()`
/// - `setLabel(String label)`
///
/// `Stream<dynamic>` allow us to monitor the sensor update
/// events as follows:
///
/// ```dart
/// sensor.onScreenOn.listen((event) {
///
/// }
/// ```
///
/// In addition, this package support data visualization function on Cart Widget.
/// You can generate the Cart Widget by following code.
/// ```dart
/// var card = ScreenCard(sensor: sensor);
/// ```
class ScreenSensor extends AwareSensor {
  static const MethodChannel _screenMethod = const MethodChannel('awareframework_screen/method');
  // static const EventChannel  _screenStream  = const EventChannel('awareframework_screen/event');

  static const EventChannel  _onScreenOnStream  = const EventChannel('awareframework_screen/event_on_screen_on');
  static const EventChannel  _onScreenOffStream  = const EventChannel('awareframework_screen/event_on_screen_off');
  static const EventChannel  _onScreenLockStream  = const EventChannel('awareframework_screen/event_on_screen_lock');
  static const EventChannel  _onScreenUnlockStream  = const EventChannel('awareframework_screen/event_on_screen_unlock');

  StreamController<dynamic> onScreenOnStreamController     = StreamController<dynamic>();
  StreamController<dynamic> onScreenOffStreamController    = StreamController<dynamic>();
  StreamController<dynamic> onScreenLockStreamController   = StreamController<dynamic>();
  StreamController<dynamic> onScreenUnlockStreamController = StreamController<dynamic>();

  bool lockState   = false;
  bool screenState = true;

  /// Init Screen Sensor without a configuration file
  ///
  /// ```dart
  /// var sensor = ScreenSensor.init(null);
  /// ```
  ScreenSensor():this.init(null);

  /// Init Screen Sensor with ScreenSensorConfig
  ///
  /// ```dart
  /// var config =  ScreenSensorConfig();
  /// config
  ///   ..debug = true
  ///   ..frequency = 100;
  ///
  /// var sensor = ScreenSensor.init(config);
  /// ```
  ScreenSensor.init(ScreenSensorConfig config) : super(config){
    super.setMethodChannel(_screenMethod);
  }

  StreamController<dynamic> initStreamController(StreamController<dynamic> controller){
    controller.close();
    controller = StreamController<dynamic>();
    return controller;
  }

  /// An event channel for monitoring sensor events.
  ///
  /// `Stream<ScreenData>` allow us to monitor the sensor update
  /// events as follows:
  ///
  /// ```dart
  /// sensor.onDataChanged.listen((data) {
  ///   print(data)
  /// }
  ///
  /// [Creating Streams](https://www.dartlang.org/articles/libraries/creating-streams)
  Stream<dynamic> get onScreenOn {
    return initStreamController(onScreenOnStreamController).stream;
  }

  Stream<dynamic> get onScreenOff {
    return initStreamController(onScreenOffStreamController).stream;
  }

  Stream<dynamic> get onScreenLocked {
    return initStreamController(onScreenLockStreamController).stream;
  }

  Stream<dynamic> get onScreenUnlocked{
    return initStreamController(onScreenUnlockStreamController).stream;
  }

  @override
  Future<Null> start() {
    super.getBroadcastStream(_onScreenOnStream, "on_screen_on").listen((event){
      if(!onScreenOnStreamController.isClosed){
        this.screenState = true;
        onScreenOnStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onScreenOffStream, "on_screen_off").listen((event){
      if(!onScreenOffStreamController.isClosed){
        this.screenState = false;
        onScreenOffStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onScreenLockStream, "on_screen_locked").listen((event){
      if(!onScreenLockStreamController.isClosed){
        this.lockState = true;
        onScreenLockStreamController.add(event);
      }
    });
    super.getBroadcastStream(_onScreenUnlockStream, "on_screen_unlocked").listen((event){
      if(!onScreenUnlockStreamController.isClosed){
        this.lockState = false;
        onScreenUnlockStreamController.add(event);
      }
    });
    return super.start();
  }

  @override
  Future<Null> stop() {
    super.cancelBroadcastStream("on_screen_on");
    super.cancelBroadcastStream("on_screen_off");
    super.cancelBroadcastStream("on_screen_locked");
    super.cancelBroadcastStream("on_screen_unlocked");
    return super.stop();
  }

}


/// A configuration class of ScreenSensor
///
/// You can initialize the class by following code.
///
/// ```dart
/// var config =  ScreenSensorConfig();
/// config
///   ..debug = true
///   ..frequency = 100;
/// ```
class ScreenSensorConfig extends AwareSensorConfig{
  ScreenSensorConfig();
  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    return map;
  }
}


///
/// A Card Widget of Screen Sensor
///
/// You can generate a Cart Widget by following code.
/// ```dart
/// var card = ScreenCard(sensor: sensor);
/// ```
///
class ScreenCard extends StatefulWidget {
  ScreenCard({Key key, @required this.sensor}) : super(key: key);

  final ScreenSensor sensor;

  @override
  ScreenCardState createState() => new ScreenCardState();
}

///
/// A Card State of Screen Sensor
///
class ScreenCardState extends State<ScreenCard> {

  String data = "Unknown";

  @override
  void initState() {

    super.initState();
    // set observer
    widget.sensor.onScreenOn.listen((event) {
      setState((){
        data = "On";
      });
    });

    widget.sensor.onScreenOff.listen((event) {
      setState((){
        data = "Off";
      });
    });

    widget.sensor.onScreenLocked.listen((event) {
      setState((){
        data = "Locked";
        print("lock");
      });
    });

    widget.sensor.onScreenUnlocked.listen((event) {
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
}
