#import "DefaultCountryCodePlugin.h"
#if __has_include(<default_country_code/default_country_code-Swift.h>)
#import <default_country_code/default_country_code-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "default_country_code-Swift.h"
#endif

@implementation DefaultCountryCodePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDefaultCountryCodePlugin registerWithRegistrar:registrar];
}
@end
