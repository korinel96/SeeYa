//
//  AdressEnter.h
//  SeeYa_v74
//
//  Created by Sergey Im on 07/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface customS : NSObject
    

@end
@interface AdressEnter : UIViewController{
    NSString *Adress1;
    NSString *Adress2;
    NSString *lp;
    NSArray *uad, *fad;
    NSArray *UserCoordinates, *FriendCoordinates;
    float MainPoint1, MainPoint2;
    NSString *UserAdress;
    NSString *FriendAdress;
}



@property (weak, nonatomic) IBOutlet UITextField *FriendsAdress;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextField *UserAdress;
@property (weak, nonatomic) IBOutlet UIButton *CheckButton;
@property (weak, nonatomic) IBOutlet UIButton *AddFriendButton;

-(void) fetchedData1:(NSData *)responseData: (int) side;
-(void) recieve_coor;
@end