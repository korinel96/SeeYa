//
//  TagTable.m
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import "TagTable.h"
#import "MapView.h"
#import <CoreLocation/CoreLocation.h>


@implementation TagTable
@synthesize tags;
@synthesize FriendCoordinates;
@synthesize UserCoordinates;
@synthesize MainPoint1;
@synthesize MainPoint2;

- (void)viewDidLoad {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.title = @"Tags";
    //Нужно увеличить кол-во статических ячеек в storyboard при добавлении тегов
    self.tags = [NSArray arrayWithObjects:@"Meal",/*@"cafe",@"restaurant", @"bakery", @"meal_takeaway",*/ @"Store",@"Library",@"Night Club",@"Museum",@"Park", nil];
    TagString = @"";
    [self.Done2 setEnabled:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        switch(indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"meal.png"];
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"store.png"];
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"library.png"];
                break;
            case 3:
                cell.imageView.image = [UIImage imageNamed:@"nightclub.png"];                break;
            case 4:
                cell.imageView.image = [UIImage imageNamed:@"museum.png"];                break;
            case 5:
                cell.imageView.image = [UIImage imageNamed:@"park.png"];                break;
            default:
                break;
        }
    }
    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    // иначе возможна только одна галочка
    /*else
     {
     cell.accessoryType = UITableViewCellAccessoryNone;
     }
     */
    cell.textLabel.text = [tags objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.lastIndexPath = indexPath;
    [tableView reloadData];
    
    switch(indexPath.row) {
        case 0:
            TagString = [TagString stringByAppendingString:@"cafe&restaurant&"];
            [self.Done2 setEnabled:YES];
            break;
        case 1:
            TagString = [TagString stringByAppendingString:@"store&"];
            [self.Done2 setEnabled:YES];
            break;
        case 2:
            TagString = [TagString stringByAppendingString:@"library&"];
            [self.Done2 setEnabled:YES];
            break;
        case 3:
            TagString = [TagString stringByAppendingString:@"night_club&"];
            [self.Done2 setEnabled:YES];
        case 4:
            TagString = [TagString stringByAppendingString:@"museum&"];
            [self.Done2 setEnabled:YES];
            break;
        case 5:
            TagString = [TagString stringByAppendingString:@"park&"];
            [self.Done2 setEnabled:YES];
            break;
        default:
            break;
            // do something by default;
    }
    
    
    
}

//wtf is it?
- (void) queryGooglePlaces: (NSString *) googleType {
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=false&key=%@", MainPoint1, MainPoint2, [NSString stringWithFormat:@"%i", 1000], googleType, APIKEY2];
    NSURL *googleRequestURL=[NSURL URLWithString:URL];
    NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
    [self fetchedData:data];
    
}
//same shit
- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    NSDictionary *immutable_json = [json objectForKey:@"results"];
    NSMutableDictionary *mutable_json = [immutable_json mutableCopy];
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:MainPoint1 longitude:MainPoint2];
    CLLocation *location2;
    for(int i=0; i < [json count]-1; i++){
    location2 = [[CLLocation alloc] initWithLatitude:[[json valueForKeyPath:@"result.geometry.location.lat"][i] floatValue] longitude:[[json valueForKeyPath:@"result.geometry.location.lng"][i] floatValue]];
    float dist = [location1 distanceFromLocation:location2];
    //[mutable_json setObject:[NSString stringWithFormat:@"%f", dist] forKey:@"id"];
      //NSLog(@"DISTANCE[%i]: %f", i, [[mutable_json valueForKeyPath:@"result.id"][i] floatValue]);
    }
    places = [json objectForKey:@"results"];
}

//NSString *APIKEY = @"AIzaSyAxYFweLCt2a10Hrxpk7hg5t-GGdbkc7fQ";
NSString *APIKEY2 = @"AIzaSyChBwHJcC-oiESi-7qJ6htfbz3ivtYSJTg";

- (IBAction)DoneButton:(id)sender {
    TagString = [TagString substringToIndex:[TagString length]-1];
    [self queryGooglePlaces: TagString];
    //[self performSelectorOnMainThread:@selector(queryGooglePlaces:) withObject: TagString waitUntilDone:YES];
    [self performSegueWithIdentifier:@"Segue2" sender:sender];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Segue2"]) {
        MapView *vc = [segue destinationViewController];
        [vc setAll_places: places];
        [vc setUserCoordinates:UserCoordinates];
        [vc setFriendCoordinates:FriendCoordinates];
        [vc setMainPoint1:MainPoint1];
        [vc setMainPoint2:MainPoint2];
    }
}





@end
