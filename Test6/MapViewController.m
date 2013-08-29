//
//  MapViewController.m
//  Test6
//
//  Created by Masashi Kawabe on 2013/08/11.
//  Copyright (c) 2013年 Masashi Kawabe. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    lm.distanceFilter = kCLDistanceFilterNone;
    [lm startUpdatingLocation];
    
    UILongPressGestureRecognizer *longPressGesture;
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(handleLongPressGesture:)];
    [_myMapView addGestureRecognizer:longPressGesture];
     //_myMapView.delegate = self; //原因

}

- (void) locationManager: (CLLocationManager *) manager
     didUpdateToLocation: (CLLocation *) newLocation
            fromLocation: (CLLocation *) oldLocation {
    
    MKCoordinateRegion region = _myMapView.region;
    
    region.center.latitude = newLocation.coordinate.latitude;
    region.center.longitude = newLocation.coordinate.longitude;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    _myMapView.showsUserLocation = YES; //現在地の青い印を表示
    
    [_myMapView setRegion:region animated:YES];
}


//長押し検出時の処理
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture
{
     _myMapView.delegate = self; //原因
    if (gesture.state == UIGestureRecognizerStateBegan) {  // 長押し検出開始時のみ動作
        
        CGPoint touchedPoint = [gesture locationInView:_myMapView];
        CLLocationCoordinate2D touchCoordinate = [_myMapView convertPoint:touchedPoint toCoordinateFromView:_myMapView];
        
        [self setAnnotation:touchCoordinate mapMove:NO animated:NO];
    }
}

//地図にピンを配置
-(void)setAnnotation:(CLLocationCoordinate2D) point mapMove:(BOOL)mapMove
            animated:(BOOL)animated{
    
    // ピンを全て削除
    //[_myMapView removeAnnotations: _myMapView.annotations];
    
    // 新しいピンを作成
    MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
    anno.coordinate = point;
    
    // ピンを追加
    [_myMapView addAnnotation:anno];
    
    //ピンの周りに円を表示
     MKCircle* circle = [MKCircle circleWithCenterCoordinate:point radius:500];  // 半径500m
     [_myMapView removeOverlays:_myMapView.overlays];
     [_myMapView addOverlay:circle];
}

//ピンが落ちてくるアニメーションの追加
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id )annotation {
    static NSString* Identifier = @"PinAnnotationIdentifier";
    MKPinAnnotationView* pinView;
    
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:Identifier];
    
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:Identifier];
    
        pinView.animatesDrop = YES; //上から落ちてくるアニメーションを追加
        pinView.pinColor = MKPinAnnotationColorPurple;  //ピンの色を紫にする
        pinView.canShowCallout = YES;
        return pinView;
    }
    
    pinView.annotation = annotation;
    
    return pinView;
}

 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
