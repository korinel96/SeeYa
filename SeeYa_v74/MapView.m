//
//  MapView.m
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import "MapView.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapView ()
@property (weak, nonatomic) IBOutlet UISearchBar *Search_bar;
@end

@implementation MapView{
    GMSMapView *mapView_;
}

//@synthesize ShareButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: MainPoint1
                                                            longitude: MainPoint2
                                                                 zoom:10];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  /*  mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES; */
    mapView_.settings.zoomGestures = YES;
    self.view = mapView_;
    
    GMSMarker *marker0 = [[GMSMarker alloc] init];
    marker0.position = CLLocationCoordinate2DMake([UserCoordinates[0] floatValue],[UserCoordinates[1] floatValue]);
    marker0.title = @"You are here";
    marker0.icon=[UIImage imageNamed:@"HumanA.png"];
    //marker.snippet = place1_ad[1];
    marker0.map = mapView_;
    
    GMSMarker *marker00 = [[GMSMarker alloc] init];
    marker00.position = CLLocationCoordinate2DMake([FriendCoordinates[0] floatValue],[FriendCoordinates[1] floatValue]);
    marker00.title = @"Your Friend is here";
    marker00.icon=[UIImage imageNamed:@"HumanB.png"];
    //marker.snippet = place1_ad[1];
    marker00.map = mapView_;
    
    //Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([place1_cr[0] floatValue], [place1_cr[1] floatValue]);
    marker.title = place1_ad[0];
    marker.icon=[UIImage imageNamed:@"Food.png"];
    //marker.snippet = place1_ad[1];
    marker.map = mapView_;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake([place2_cr[0] floatValue], [place2_cr[1] floatValue]);
    marker2.title = place2_ad[0];
    marker2.icon=[UIImage imageNamed:@"Food.png"];
    //marker2.snippet = place2_ad[1];
    marker2.map = mapView_;
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake([place3_cr[0] floatValue], [place3_cr[1] floatValue]);
    marker3.title = place3_ad[0];
    marker3.icon=[UIImage imageNamed:@"Food.png"];
    // marker3.snippet = place3_ad[1];
    marker3.map = mapView_;
    
    UIImage *btnImage = [UIImage imageNamed:@"share.png"];
    [self.ShareButton setImage:btnImage forState:UIControlStateNormal];
    self.ShareButton.tintColor = [UIColor grayColor];
    
    UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(249, 299, 99, 23)];
    [slider addTarget:self action:@selector(mySliderChanged:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 3;
    slider.maximumValue = 9;
    slider.continuous = YES;
    slider.value = 3;
    slider .transform = CGAffineTransformMakeRotation(-90.0*M_PI/180.0);
    [mapView_ addSubview: slider];
}

-(NSNumber *)updateSliderStepValueWithSlider:(UISlider *)slider {
    NSInteger sliderStepValue = 1.0f;
    float newStep = roundf((slider.value) / sliderStepValue);
    slider.value = newStep * sliderStepValue;
    
    return [NSNumber numberWithFloat:slider.value];
}

- (IBAction)mySliderChanged:(UISlider *)sender {
    NSNumber *sliderStepValue = [self updateSliderStepValueWithSlider:sender];

}

- (IBAction)ShareButtonAction:(id)sender{
    NSString *message = @"AIM!";
    NSArray *postItems = @[message];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    [self presentViewController:activityVC animated:NO completion:nil];
}

@end
