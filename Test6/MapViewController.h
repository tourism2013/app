//
//  MapViewController.h
//  Test6
//
//  Created by Masashi Kawabe on 2013/08/11.
//  Copyright (c) 2013年 Masashi Kawabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate> {
    CLLocationManager *lm;
}
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(UIView *)view;
@end
