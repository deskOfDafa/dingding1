//
//  DingtalkPluginConfig.h
//  dingding1Dylib
//
//  Created by jack ma on 2017/10/9.
//  Copyright © 2017年 jack ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class DingtalkPluginConfig;
extern DingtalkPluginConfig* pluginConfig;

@interface DingtalkPluginConfig : NSObject

+(DingtalkPluginConfig*)sharedInstance;
/**
 经纬度
 */
@property(nonatomic, assign) CLLocationCoordinate2D location;

@end
