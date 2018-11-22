#import "AwareframeworkScreenPlugin.h"
#import <awareframework_screen/awareframework_screen-Swift.h>

@implementation AwareframeworkScreenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAwareframeworkScreenPlugin registerWithRegistrar:registrar];
}
@end
