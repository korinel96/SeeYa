//
//  ContainerView.m
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import "ContainerView.h"
#import "Global.h"

@interface ContainerView ()

@end


NSString *APIKEY = @"AIzaSyAxYFweLCt2a10Hrxpk7hg5t-GGdbkc7fQ"; //Kim's key 1000 requests per day
//NSString *APIKEY = @"AIzaSyChBwHJcC-oiESi-7qJ6htfbz3ivtYSJTg"; //ImS' key 100000 requests per day

@implementation ContainerView

- (IBAction)DoneButton:(id)sender {
    TagString = [TagString substringToIndex:[TagString length]-1];
    [self queryGooglePlaces: TagString];
}
- (void)viewDidLoad {
    UIImage *btnImage = [UIImage imageNamed:@"check.png"];
    [self.Done setImage:btnImage forState:UIControlStateNormal];
    [super viewDidLoad];
}

//wtf is it?
- (void) queryGooglePlaces: (NSString *) googleType {
    MainPoint1=([UserCoordinates[0] floatValue]+[FriendCoordinates[0] floatValue])/2;
    MainPoint2=([FriendCoordinates[1] floatValue]+[UserCoordinates[1] floatValue])/2;
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&langeage=russian&types=%@&sensor=false&key=%@", MainPoint1, MainPoint2, [NSString stringWithFormat:@"%i", 500], googleType, APIKEY];
    NSURL *googleRequestURL=[NSURL URLWithString:URL];
    NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
    [self fetchedData:data];
    // [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    
}
//same shit
- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    places = [json objectForKey:@"results"];
    NSLog(places[0][@"vicinity"]);
}
@end
