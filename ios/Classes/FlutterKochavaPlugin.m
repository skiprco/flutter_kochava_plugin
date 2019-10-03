#import "FlutterKochavaPlugin.h"
//#import <flutter_kochava_plugin/flutter_kochava_plugin-Swift.h>
//#import <KochavaTrackeriOS/KochavaCore.h>
#import "KochavaTracker.h"

@implementation FlutterKochavaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* nativeChannel = [FlutterMethodChannel
    methodChannelWithName:@"flutter_kochava_plugin"
    binaryMessenger: registrar.messenger];
    
    [nativeChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        id arguments = call.arguments;
        if ([@"configure" isEqualToString:call.method]) {
            if (call.arguments != nil && [call.arguments isKindOfClass:[NSString class]] && [call.arguments length] > 0) {
                [KochavaTracker.shared configureWithParametersDictionary:@{kKVAParamAppGUIDStringKey: call.arguments} delegate:nil];
                result(@"success");
            } else {
                result([FlutterError errorWithCode:@"0" message:@"incorrect appId" details:@""]);
            }
        } else if ([@"sendEvent" isEqualToString:call.method]) {
            if (arguments == nil || ![call.arguments isKindOfClass:[NSDictionary class]]) {
                result([FlutterError errorWithCode:@"0" message:@"incorrect arguments" details:@""]);
                return;
            }
            NSString *type = [arguments objectForKey:@"type"];
            if (type == nil || ![type isKindOfClass:[NSString class]] || [type length] == 0) {
                result([FlutterError errorWithCode:@"0" message:@"incorrect type" details:@""]);
                return;
            }
            if ([type isEqualToString: @"customEvent"]) {
                NSString *nameString = [arguments objectForKey:@"nameString"];
                if (nameString == nil || [nameString length] == 0) {
                    result([FlutterError errorWithCode:@"0" message:@"customEvent empty nameString" details:@""]);
                    return;
                }
                KochavaEvent *event = [KochavaEvent customEventWithEventNameString: nameString];
                event.nameString = nameString;
                event.infoDictionary = [arguments objectForKey:@"infoDictionary"];
                event.userIdString = [arguments objectForKey:@"userIdString"];
                [KochavaTracker.shared sendEvent:event];
                result(@"success");
                
            } else if ([type isKindOfClass:[NSString class]] && [type isEqualToString: @"searchEvent"]) {
                KochavaEvent *event = [KochavaEvent eventWithEventTypeEnum: KochavaEventTypeEnumSearch];
                event.uriString = [arguments objectForKey:@"uri"];
                event.resultsString = [arguments objectForKey:@"results"];
                event.userIdString = [arguments objectForKey:@"userIdString"];
                result(@"success");
                
            } else {
                result([FlutterError errorWithCode:@"0" message:@"unhandled type arguments" details:@""]);
            }
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}
@end
