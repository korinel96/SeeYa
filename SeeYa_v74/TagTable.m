//
//  TagTable.m
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import "TagTable.h"
#import "MapView.h"


@implementation TagTable
@synthesize tags;
@synthesize tagNum;
@synthesize PoluchilStr;

- (void)viewDidLoad {
    NSLog(@"%@", self.PoluchilStr);
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


//NSString *APIKEY = @"AIzaSyAxYFweLCt2a10Hrxpk7hg5t-GGdbkc7fQ";
NSString *APIKEY2 = @"AIzaSyChBwHJcC-oiESi-7qJ6htfbz3ivtYSJTg";

- (IBAction)DoneButton:(id)sender {
    TagString = [TagString substringToIndex:[TagString length]-1];
    [self performSegueWithIdentifier:@"Segue2" sender:sender];
    [self queryGooglePlaces: TagString];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Segue2"]) {
        
        // Get destination view
        MapView *vc = [segue destinationViewController];
        
        NSArray *tagIndex;
        tagIndex = [NSArray arrayWithObjects:@"Meal",/*@"cafe",@"restaurant", @"bakery", @"meal_takeaway",*/ @"Store",@"Library",@"Night Club",@"Museum",@"Park", nil];
        NSString *strtry= @"blahahbar";
        
        // Set the selected button in the new view
        [vc setPuluchilArr: tagIndex];
        [vc setPoluchilStr: strtry];
    }
}


//wtf is it?
- (void) queryGooglePlaces: (NSString *) googleType {
    MainPoint1=([UserCoordinates[0] floatValue]+[FriendCoordinates[0] floatValue])/2;
    MainPoint2=([FriendCoordinates[1] floatValue]+[UserCoordinates[1] floatValue])/2;
    NSString *URL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=false&key=%@", MainPoint1, MainPoint2, [NSString stringWithFormat:@"%i", 1000], googleType, APIKEY2];
    NSURL *googleRequestURL=[NSURL URLWithString:URL];
    NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
    NSLog(URL);
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
    
    all_places = [json objectForKey:@"results"];
}


@end
