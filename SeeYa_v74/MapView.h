//
//  MapView.h
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface MapView : UIViewController{
    NSArray *TagString;
    NSString *PuluchilArr;
    NSArray* all_places;
}

-(void) queryGooglePlaces: (NSString *) googleType ;
-(void) fetchedData:(NSData *)responseData;
@property (nonatomic, readwrite) NSArray* PuluchilArr;
@property (readwrite, nonatomic) NSString *PoluchilStr;
@property (weak, nonatomic) IBOutlet UIButton *ShareButton;
@end
