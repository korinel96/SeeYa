//
//  AdressEnter.h
//  SeeYa_v74
//
//  Created by Sergey Im on 07/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "ContainerView.h"

NSString *Adress1;
NSString *Adress2;
NSString *lp;
NSArray *uad, *fad;

@interface AdressEnter : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *FriendsAdress;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextField *UserAdress;

@property (weak, nonatomic) IBOutlet UIButton *CheckButton;
@property (weak, nonatomic) IBOutlet UIButton *AddFriendButton;

-(void) fetchedData1:(NSData *)responseData: (int) side;
-(void) recieve_coor;
@end