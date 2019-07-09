#import "NativeWebViewPlugin.h"
#import "WebViewController.h"

@implementation NativeWebViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"native_web_view"
            binaryMessenger:[registrar messenger]];
  NativeWebViewPlugin* instance = [[NativeWebViewPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"showWebView" isEqualToString:call.method]){
      [WebViewController showView:call.arguments];
  }else if([@"hideWebView" isEqualToString:call.method]){
      [WebViewController hiddenView:call.arguments];
  }else if ([@"deleteView" isEqualToString:call.method]){
      [WebViewController deleteView:call.arguments];
  }
  else{
    result(FlutterMethodNotImplemented);
  }
}

@end
