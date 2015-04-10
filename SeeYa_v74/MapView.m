//
//  MapView.m
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import "MapView.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Global.h"

@interface MapView ()
@property (weak, nonatomic) IBOutlet UISearchBar *Search_bar;
@end




@implementation MapView{
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: MainPoint1
                                                            longitude: MainPoint2
                                                                 zoom:10];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.zoomGestures = YES;
    self.view = mapView_;
    
    GMSMarker *marker0 = [[GMSMarker alloc] init];
    marker0.position = CLLocationCoordinate2DMake([UserCoordinates[0] floatValue],[UserCoordinates[1] floatValue]);
    marker0.title = @"You are here";
    //marker.snippet = place1_ad[1];
    marker0.map = mapView_;
    
    GMSMarker *marker00 = [[GMSMarker alloc] init];
    marker00.position = CLLocationCoordinate2DMake([FriendCoordinates[0] floatValue],[FriendCoordinates[1] floatValue]);
    marker00.title = @"Your Friend is here";
    //marker.snippet = place1_ad[1];
    marker00.map = mapView_;
    
    //Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(place1.lat, place1.lng);
    marker.title = place1.name;
    marker.snippet = place1.address;
    marker.map = mapView_;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake(place2.lat, place2.lng);
    marker2.title = place2.name;
    marker2.snippet = place2.address;
    marker2.map = mapView_;
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake(place3.lat, place3.lng);
    marker3.title = place3.name;
    marker3.snippet = place3.address;
    marker3.map = mapView_;
    
    UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(249, 299, 99, 23)];
    [slider addTarget:self action:@selector(mySliderChanged:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 3;
    slider.maximumValue = 9;
    slider.continuous = YES;
    slider.value = 3;
//  [slider release];
    slider .transform = CGAffineTransformMakeRotation(-90.0*M_PI/180.0);
    [mapView_ addSubview: slider];

}

-(NSNumber *)updateSliderStepValueWithSlider:(UISlider *)slider {
    NSInteger sliderStepValue = 1.0f;
    float newStep = roundf((slider.value) / sliderStepValue);
    slider.value = newStep * sliderStepValue;
 //       NSLog(@"%f",slider.value);
    
    return [NSNumber numberWithFloat:slider.value];
}

- (IBAction)mySliderChanged:(UISlider *)sender {
    NSNumber *sliderStepValue = [self updateSliderStepValueWithSlider:sender];

}
@end
