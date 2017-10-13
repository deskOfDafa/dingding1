//
//  MapViewController.h
//  dingding1
//
//  Created by jack ma on 2017/10/10.
//  Copyright © 2017年 jack ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
@property(nonatomic,copy) void (^block)(double ,double);
@end
