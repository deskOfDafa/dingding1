//
//  MapViewController.m
//  dingding1
//
//  Created by jack ma on 2017/10/10.
//  Copyright © 2017年 jack ma. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface MapViewController ()<MAMapViewDelegate>
@property (nonatomic,strong) MAPointAnnotation *pointAnnotation;
@property (nonatomic ,strong)  MAMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapServices sharedServices].enableHTTPS = YES;
   _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
    _mapView.delegate = self;
    [_mapView setZoomLevel:19 animated:YES];
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22);  //设置比例尺位置
    ///把地图添加至view
    [self.view addSubview:_mapView];
 
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    
    if (!_pointAnnotation) {
        _pointAnnotation = [[MAPointAnnotation alloc] init];
        _pointAnnotation.coordinate =_mapView.userLocation.location.coordinate;
        _pointAnnotation.title = @"提示";
        _pointAnnotation.subtitle = @"拖拽大头针拾取坐标";
        [_mapView addAnnotation:_pointAnnotation];
    }

}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
       annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        
        return annotationView;
    }
    
    return nil;
}
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldStat{
    
    _block(_pointAnnotation.coordinate.longitude,_pointAnnotation.coordinate.latitude);
    NSLog(@"=======================lat%f,lon%f",_pointAnnotation.coordinate.latitude,_pointAnnotation.coordinate.longitude);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
