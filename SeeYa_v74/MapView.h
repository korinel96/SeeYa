//
//  MapView.h
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface MapView : UIViewController{
    NSArray *UserCoordinates;
    NSArray *FriendCoordinates;
    NSMutableArray *all_places;
    float MainPoint1, MainPoint2;
}

@property (nonatomic, readwrite) NSArray* all_places;
@property (readwrite, nonatomic) NSArray* FriendCoordinates;
@property (readwrite, nonatomic) NSArray* UserCoordinates;
@property (nonatomic, assign) float MainPoint1;
@property (nonatomic, assign) float MainPoint2;
@property (weak, nonatomic) IBOutlet UIButton *ShareButton;
@end
