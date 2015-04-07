//
//  ContainerView.h
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import <UIKit/UIKit.h>
@interface ContainerView : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *Done;
-(void) queryGooglePlaces: (NSString *) googleType;
-(void) fetchedData:(NSData *)responseData;
@end
