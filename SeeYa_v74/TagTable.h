//
//  TagTable.h
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagTable :UITableViewController{
    NSArray *tags;
    NSMutableArray* places;
    NSArray *UserCoordinates;
    NSArray *FriendCoordinates;
    float MainPoint1, MainPoint2;
    NSString *TagString;

}


@property (weak, nonatomic) IBOutlet UIButton *Done2;
@property (nonatomic, assign) float MainPoint1;
@property (nonatomic, assign) float MainPoint2;
@property (readwrite, nonatomic) NSArray* FriendCoordinates;
@property (readwrite, nonatomic) NSArray* UserCoordinates;
@property(retain)  NSIndexPath* lastIndexPath;
@property (nonatomic, retain) NSArray *tags;

-(void) queryGooglePlaces: (NSString *) googleType;
-(void) fetchedData:(NSData *)responseData;

@end