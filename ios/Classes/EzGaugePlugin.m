#import "EzGaugePlugin.h"
#if __has_include(<ez_gauge/ez_gauge-Swift.h>)
#import <ez_gauge/ez_gauge-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ez_gauge-Swift.h"
#endif

@implementation EzGaugePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEzGaugePlugin registerWithRegistrar:registrar];
}
@end
