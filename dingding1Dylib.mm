#line 1 "/Users/jackma/Desktop/dingding1/dingding1Dylib/dingding1Dylib.xm"



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class DTAppDelegate; 
static void (*_logos_orig$_ungrouped$DTAppDelegate$applicationDidBecomeActive$)(_LOGOS_SELF_TYPE_NORMAL DTAppDelegate* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$DTAppDelegate$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL DTAppDelegate* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$_ungrouped$DTAppDelegate$application$didFinishLaunchingWithOptions$)(_LOGOS_SELF_TYPE_NORMAL DTAppDelegate* _LOGOS_SELF_CONST, SEL, id, id); static BOOL _logos_method$_ungrouped$DTAppDelegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL DTAppDelegate* _LOGOS_SELF_CONST, SEL, id, id); 

#line 3 "/Users/jackma/Desktop/dingding1/dingding1Dylib/dingding1Dylib.xm"
#import <UIKit/UIKit.h>
#import "MenuWindow/WBAssistantManager.h"
#import "WBWifiStore.h"
#import "WBWifiModel.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


static void _logos_method$_ungrouped$DTAppDelegate$applicationDidBecomeActive$(_LOGOS_SELF_TYPE_NORMAL DTAppDelegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    _logos_orig$_ungrouped$DTAppDelegate$applicationDidBecomeActive$(self, _cmd, arg1);
    
    [[WBAssistantManager sharedManager] showMenu];
}
static BOOL _logos_method$_ungrouped$DTAppDelegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL DTAppDelegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    [AMapServices sharedServices].apiKey = @"6313295fe6fb296fe621b257819607b7";
    _logos_orig$_ungrouped$DTAppDelegate$application$didFinishLaunchingWithOptions$(self, _cmd, arg1, arg2);
}

CFArrayRef (*oldCNCopySupportedInterfaces)();
CFDictionaryRef (*oldCNCopyCurrentNetworkInfo)(CFStringRef interfaceName);
Boolean (*oldSCNetworkReachabilityGetFlags)(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags *flags);

CFArrayRef newCNCopySupportedInterfaces() {
    CFArrayRef result = NULL;
    
    WBWifiModel *wifi = [[WBWifiStore sharedStore] wifiHooked];
    
    if(wifi && wifi.interfaceName) {
        NSArray *array = [NSArray arrayWithObject:wifi.interfaceName];
        result = (CFArrayRef)CFRetain((__bridge CFArrayRef)(array));
    }
    
    if(!result) {
        result = oldCNCopySupportedInterfaces();
    }
    
    return result;
}

CFDictionaryRef newCNCopyCurrentNetworkInfo(CFStringRef interfaceName) {
    CFDictionaryRef result = NULL;
    
    WBWifiModel *wifi = [[WBWifiStore sharedStore] wifiHooked];
    if(wifi) {
        NSDictionary *dictionary = @{
                                     @"BSSID": (wifi.BSSID ? wifi.BSSID : @""),
                                     @"SSID": (wifi.SSID ? wifi.SSID : @""),
                                     @"SSIDDATA": (wifi.SSIDData ? wifi.SSIDData : @"")
                                     };
        result = (CFDictionaryRef)CFRetain((__bridge CFDictionaryRef)(dictionary));
    }
    
    if(!result) {
        result = oldCNCopyCurrentNetworkInfo(interfaceName);
    }
    
    return result;
}

Boolean newSCNetworkReachabilityGetFlags(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags *flags) {
    Boolean result = false;
    
    WBWifiModel *wifi = [[WBWifiStore sharedStore] wifiHooked];
    if(wifi && wifi.flags > 0) {
        result = true;
        *flags = wifi.flags;
    }
    
    if(!result) {
        result = oldSCNetworkReachabilityGetFlags(target, flags);
    }
    
    return result;
}

static __attribute__((constructor)) void _logosLocalCtor_bdbb22fb(int __unused argc, char __unused **argv, char __unused **envp) {
    {Class _logos_class$_ungrouped$DTAppDelegate = objc_getClass("DTAppDelegate"); MSHookMessageEx(_logos_class$_ungrouped$DTAppDelegate, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$_ungrouped$DTAppDelegate$applicationDidBecomeActive$, (IMP*)&_logos_orig$_ungrouped$DTAppDelegate$applicationDidBecomeActive$);MSHookMessageEx(_logos_class$_ungrouped$DTAppDelegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$_ungrouped$DTAppDelegate$application$didFinishLaunchingWithOptions$, (IMP*)&_logos_orig$_ungrouped$DTAppDelegate$application$didFinishLaunchingWithOptions$);}
    
    MSHookFunction(&CNCopySupportedInterfaces, &newCNCopySupportedInterfaces, &oldCNCopySupportedInterfaces);
    MSHookFunction(&CNCopyCurrentNetworkInfo, &newCNCopyCurrentNetworkInfo, &oldCNCopyCurrentNetworkInfo);
    MSHookFunction(&SCNetworkReachabilityGetFlags, &newSCNetworkReachabilityGetFlags, &oldSCNetworkReachabilityGetFlags);
}
