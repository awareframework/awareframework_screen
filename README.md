# Aware Screen

[![Build Status](https://travis-ci.org/awareframework/awareframework_screen.svg?branch=master)](https://travis-ci.org/awareframework/awareframework_screen)

The screen sensor monitors the screen statuses, such as turning on and off, locked and unlocked.

## Install the plugin into project
1. Edit `pubspec.yaml`
```
dependencies:
    awareframework_screen
```

2. Import the package on your source code
```
import 'package:awareframework_screen/awareframework_screen.dart';
import 'package:awareframework_core/awareframework_core.dart';
```

## Public functions
### screen Sensor
- `start()`
- `stop()` 
- `sync(bool force)`
- `enable()`
- `disable()`
- `isEnable()`
- `setLabel(String label)`

### Configuration Keys
TODO
- `period`: Float: Period to save data in minutes. (default = 1)
- `threshold`: Double: If set, do not record consecutive points if change in value is less than the set value.
- `enabled`: Boolean Sensor is enabled or not. (default = false)
- `debug`: Boolean enable/disable logging to Logcat. (default = false)
- `label`: String Label for the data. (default = "")
- `deviceId`: String Id of the device that will be associated with the events and the sensor. (default = "")
- `dbEncryptionKey` Encryption key for the database. (default = null)
- `dbType`: Engine Which db engine to use for saving data. (default = 0) (0 = None, 1 = Room or Realm)
- `dbPath`: String Path of the database. (default = "aware_accelerometer")
- `dbHost`: String Host for syncing the database. (default = null)

## Data Representations
The data representations is different between Android and iOS. Following links provide the information.
- [Android](https://github.com/awareframework/com.awareframework.android.sensor.screen)
- [iOS](https://github.com/awareframework/com.awareframework.ios.sensor.screen)

## Example usage
```dart
// init config
var config = ScreenSensorConfig()
  ..debug = true
  ..label = "label";

// init sensor
var sensor = new ScreenSensor.init(config);

void method(){
    /// start 
    sensor.start();
    
    /// set observer
    sensor.onDataChanged.listen((ScreenData result){
      setState((){
        // Your code here
      });
    });
    
    /// stop
    sensor.stop();
    
    /// sync
    sensor.sync(true);  
    
    // make a sensor care by the following code
    var card = new ScreenCard(sensor:sensor);
    // NEXT: Add the card instance into a target Widget.
}

```

## License
Copyright (c) 2018 AWARE Mobile Context Instrumentation Middleware/Framework (http://www.awareframework.com)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LI
CENSE-2.0 Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
