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


NSString *APIKEY = @"AIzaSyAxYFweLCt2a10Hrxpk7hg5t-GGdbkc7fQ"; //Kim's key
//NSString *APIKEY = @"AIzaSyChBwHJcC-oiESi-7qJ6htfbz3ivtYSJTg"; //ImS' key

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
    place1 = [[info_struct alloc] init];
    place2 = [[info_struct alloc] init];
    place3 = [[info_struct alloc] init];
    MainPoint1=([UserCoordinates[0] floatValue]+[FriendCoordinates[0] floatValue])/2;
    MainPoint2=([FriendCoordinates[1] floatValue]+[UserCoordinates[1] floatValue])/2;
    // NSLog(@"MAIN1%f_MAIN2%f_1%@_2%@_3%@_4%@",MainPoint2,MainPoint1,urcr[0],urcr[1],frcr[0],frcr[1]);
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=false&key=%@", MainPoint1, MainPoint2, [NSString stringWithFormat:@"%i", 500], googleType, APIKEY];
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
    
    NSArray* places = [json objectForKey:@"results"];
    if ([places count] != 0)
    {
        place1.open = 2;
        place1.name = places[0][@"name"];
        place1.address=places[0][@"vinicity"];
        place1.lat=[places[0][@"geometry"][@"location"][@"lat"] floatValue];
        place1.lng=[places[0][@"geometry"][@"location"][@"lng"] floatValue];
        if ([places[0][@"opening_hours"][@"open_now"] isEqualToString: @"true"])
        {
            place1.open = 1;
        }
        else {
            place1.open = 0;
        }
        place1.price_lvl = 0;
        place1.price_lvl = [places[0][@"price_level"] integerValue];
        place1.rating = 0.0;
        place1.rating = [places[0][@"rating"] floatValue];
        
    };
    if ([places count] > 1)
    {
        place2.name = places[1][@"name"];
        place2.address=places[1][@"vinicity"];
        place2.lat=[places[1][@"geometry"][@"location"][@"lat"] floatValue];
        place2.lng=[places[1][@"geometry"][@"location"][@"lng"] floatValue];
        if ([places[1][@"opening_hours"][@"open_now"] isEqualToString: @"true"])
        {
            place2.open = 1;
        }
        else {
            place2.open = 0;
        }
        place2.price_lvl = 0;
        place2.price_lvl = [places[1][@"price_level"] integerValue];
        place2.rating = 0.0;
        place2.rating = [places[1][@"rating"] floatValue];
    };
    
    if ([places count] > 2)
    {
        place3.name = places[2][@"name"];
        place3.address=places[2][@"vinicity"];
        place3.lat=[places[2][@"geometry"][@"location"][@"lat"] floatValue];
        place3.lng=[places[2][@"geometry"][@"location"][@"lng"] floatValue];
        if ([places[2][@"opening_hours"][@"open_now"] isEqualToString: @"true"])
        {
            place3.open = 1;
        }
        else {
            place3.open = 0;
        }
        place3.price_lvl = 0;
        place3.price_lvl = [places[2][@"price_level"] integerValue];
        place3.rating = 0.0;
        place3.rating = [places[2][@"rating"] floatValue];
    };
    
}
@end
