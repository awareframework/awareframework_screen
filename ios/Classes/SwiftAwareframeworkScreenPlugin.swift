import Flutter
import UIKit
import SwiftyJSON
import com_awareframework_ios_sensor_screen
import com_awareframework_ios_sensor_core
import awareframework_core

public class SwiftAwareframeworkScreenPlugin: AwareFlutterPluginCore, FlutterPlugin, AwareFlutterPluginSensorInitializationHandler, ScreenObserver{


    public func initializeSensor(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> AwareSensor? {
        if self.sensor == nil {
            if let config = call.arguments as? Dictionary<String,Any>{
                let json = JSON.init(config)
                self.screenSensor = ScreenSensor.init(ScreenSensor.Config(json))
            }else{
                self.screenSensor = ScreenSensor.init(ScreenSensor.Config())
            }
            self.screenSensor?.CONFIG.sensorObserver = self
            return self.screenSensor
        }else{
            return nil
        }
    }

    var screenSensor:ScreenSensor?

    public override init() {
        super.init()
        super.initializationCallEventHandler = self
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        // add own channel
        super.setChannels(with: registrar,
                          instance: SwiftAwareframeworkScreenPlugin(),
                          methodChannelName: "awareframework_screen/method",
                          eventChannelName: "awareframework_screen/event")

    }

    public func onScreenOn() {
        for handler in self.streamHandlers {
            if handler.eventName == "on_screen_on" {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onScreenOff() {
        for handler in self.streamHandlers {
            if handler.eventName == "on_screen_off" {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onScreenLocked() {
        for handler in self.streamHandlers {
            if handler.eventName == "on_screen_locked" {
                handler.eventSink(nil)
            }
        }
    }
    
    public func onScreenUnlocked() {
        for handler in self.streamHandlers {
            if handler.eventName == "on_screen_unlocked" {
                handler.eventSink(nil)
            }
        }
    }
}
