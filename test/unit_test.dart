import 'package:test/test.dart';
import 'package:awareframework_screen/awareframework_screen.dart';

void main(){
  test("test sensor config", (){
    var config = ScreenSensorConfig();
    expect(config.debug, false);
  });
}