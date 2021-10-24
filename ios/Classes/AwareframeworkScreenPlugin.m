#import "AwareframeworkScreenPlugin.h"
#if __has_include(<awareframework_screen/awareframework_screen-Swift.h>)
#import <awareframework_screen/awareframework_screen-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "awareframework_screen-Swift.h"
#endif

@implementation AwareframeworkScreenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAwareframeworkScreenPlugin registerWithRegistrar:registrar];
}
@end
