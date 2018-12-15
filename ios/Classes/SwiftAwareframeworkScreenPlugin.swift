import Flutter
import UIKit
import com_awareframework_ios_sensor_screen
import com_awareframework_ios_sensor_core
import awareframework_core

public class SwiftAwareframeworkScreenPlugin: AwareFlutterPluginCore, FlutterPlugin, AwareFlutterPluginSensorInitializationHandler, ScreenObserver{
    
    public func initializeSensor(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> AwareSensor? {
        if self.sensor == nil {
            if let config = call.arguments as? Dictionary<String,Any>{
                self.screenSensor = ScreenSensor.init(ScreenSensor.Config(config))
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
        let instance = SwiftAwareframeworkScreenPlugin()
        super.setMethodChannel(with: registrar, instance: instance, channelName: "awareframework_screen/method")
        super.setEventChannels(with: registrar,
                               instance: instance,
                               channelNames: ["awareframework_screen/event",
                                            "awareframework_screen/event_on_screen_on",
                                            "awareframework_screen/event_on_screen_off",
                                            "awareframework_screen/event_on_screen_lock",
                                            "awareframework_screen/event_on_screen_unlock"])
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
    
    public func onScreenBrightnessChanged(data: ScreenBrightnessData) {
        
    }

}
