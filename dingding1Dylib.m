//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  dingding1Dylib.m
//  dingding1Dylib
//
//  Created by jack ma on 2017/9/19.
//  Copyright (c) 2017年 jack ma. All rights reserved.
//

#import "dingding1Dylib.h"
#import<CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import<SystemConfiguration/SystemConfiguration.h>
#import "DingtalkPluginConfig.h"
#import "DingtalkPluginConfig.h"
static __attribute__((constructor)) void entry(){
    NSLog(@"\n               🎉!!！congratulations!!！🎉\n👍----------------insert dylib success----------------👍");
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CYListenServer(6666);
    }];
}



CHDeclareClass(CLLocation);

CHOptimizedMethod0(self, CLLocationCoordinate2D, CLLocation, coordinate){
    CLLocationCoordinate2D coordinate = CHSuper(0, CLLocation, coordinate);
    if(pluginConfig.location.longitude || pluginConfig.location.latitude ){
        coordinate = pluginConfig.location;
    }
    return coordinate;
    
    
}

CHConstructor{
    CHLoadLateClass(CLLocation);
    CHClassHook(0, CLLocation, coordinate);
}


CHDeclareClass(AMapGeoFenceManager);
CHMethod(0, BOOL,AMapGeoFenceManager,detectRiskOfFakeLocation){
    
    return NO;
}
CHMethod(0, BOOL,AMapGeoFenceManager,pausesLocationUpdatesAutomatically){
    
    return NO;
}
CHConstructor{
    CHLoadLateClass(AMapGeoFenceManager);
    CHClassHook(0, AMapGeoFenceManager,detectRiskOfFakeLocation);
    CHClassHook(0, AMapGeoFenceManager,pausesLocationUpdatesAutomatically);
}




CHDeclareClass(AMapLocationManager);
CHMethod(0, BOOL,AMapLocationManager,detectRiskOfFakeLocation){
    
    return NO;
}
CHMethod(0, BOOL,AMapLocationManager,pausesLocationUpdatesAutomatically){
    
    return NO;
}
CHConstructor{
    CHLoadLateClass(AMapLocationManager);
    CHClassHook(0, AMapLocationManager,detectRiskOfFakeLocation);
    CHClassHook(0, AMapLocationManager,pausesLocationUpdatesAutomatically);
}





CHDeclareClass(DTALocationManager);
CHMethod(0, BOOL,DTALocationManager,detectRiskOfFakeLocation){
    
    return NO;
}
CHMethod(0, BOOL,DTALocationManager,dt_pausesLocationUpdatesAutomatically){
    
    return NO;
}
CHConstructor{
    CHLoadLateClass(DTALocationManager);
    CHClassHook(0, DTALocationManager,detectRiskOfFakeLocation);
    CHClassHook(0, DTALocationManager,dt_pausesLocationUpdatesAutomatically);
}




