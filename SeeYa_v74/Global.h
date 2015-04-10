//
//  Global.h
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#ifndef SeeYa_v74_Global_h
#define SeeYa_v74_Global_h
#import <Foundation/Foundation.h>

@interface info_struct : NSObject
    @property   NSString *address;
    @property   NSString *name;
    @property   float lng;
    @property   float lat;
    @property   float rating;
    @property   int price_lvl;
    @property   int open;

@end

@implementation info_struct
@synthesize address, name, lng, lat, rating, price_lvl, open;

@end

NSString *UserAdress;
NSString *FriendAdress;
NSString *TagString;
NSMutableArray *UserCoordinates, *FriendCoordinates;
extern info_struct *place1, *place2, *place3;
float MainPoint1;
float MainPoint2;
#endif
