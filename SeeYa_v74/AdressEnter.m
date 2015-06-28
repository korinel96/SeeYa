//
//  AdressEnter.m
//  SeeYa_v74
//
//  Created by Sergey Im on 07/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import "AdressEnter.h"
#import <GoogleMaps/GoogleMaps.h>
#import "TagTable.h"
#import "MapView.h"

@interface AdressEnter ()
@end

//NSString *KEY = @"AIzaSyAxYFweLCt2a10Hrxpk7hg5t-GGdbkc7fQ";
NSString *KEY = @"AIzaSyChBwHJcC-oiESi-7qJ6htfbz3ivtYSJTg";

@implementation AdressEnter

//Получение координат?(wut) назови переменные нормально
- (void) recieve_coor {
    NSString *url1 = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true_or_false", Adress1];
    NSURL *googleRequestURL1=[NSURL URLWithString:[url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData* data1 = [NSData dataWithContentsOfURL: googleRequestURL1];
    
    [self fetchedData1:data1:1];
    NSString *url2 = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true_or_false", Adress2];
    NSURL *googleRequestURL2=[NSURL URLWithString:[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData* data2 = [NSData dataWithContentsOfURL: googleRequestURL2];
    [self fetchedData1:data2:2];
    //[self performSelectorOnMainThread:@selector(fetchedData1::) withObject:data2:ad1 waitUntilDone:YES];
}

// что здесь творится?
-(void)fetchedData1:(NSData*) responseData: (int) side{
    //parse out the json data
    NSError* error1;
    NSDictionary *json1 = [NSJSONSerialization
                           JSONObjectWithData:responseData
                           
                           options:kNilOptions
                           error:&error1];
    
    NSArray* places_for = [json1 objectForKey:@"results"];
    if ([places_for count] != 0)
    {
        if(side == 1)
        {
            FriendCoordinates = [NSMutableArray arrayWithObjects:
                    places_for[0][@"geometry"][@"location"][@"lat"], places_for[0][@"geometry"][@"location"][@"lng"], nil];
        }
        else
        {
            UserCoordinates = [NSMutableArray arrayWithObjects:
                    places_for[0][@"geometry"][@"location"][@"lat"], places_for[0][@"geometry"][@"location"][@"lng"], nil];
        }
    }
    MainPoint1=([UserCoordinates[0] floatValue]+[FriendCoordinates[0] floatValue])/2;
    MainPoint2=([UserCoordinates[1] floatValue]+[FriendCoordinates[1] floatValue])/2;
}

- (IBAction)CheckButton:(id)sender{
    
    //проверка на заполненость textField
    if (([self.UserAdress.text isEqual:@""]) || ([self.FriendsAdress.text isEqual:@""])){
        [self.errorLabel setHidden:NO];
    }
    else
    {
        uad = [ self.UserAdress.text componentsSeparatedByString: @" " ];
        fad = [ self.FriendsAdress.text componentsSeparatedByString: @" " ];
        
        Adress1 = @"";
        Adress2 = @"";
        for (int i=0; i<[uad count]; i++ )
        {
            Adress1 = [Adress1 stringByAppendingString: [NSString stringWithFormat:@"%@+", uad[i]]];
        };
        Adress1 = [Adress1 stringByAppendingString:@"Moscow"];
        for (int i=0; i<[fad count]; i++ )
        {
            Adress2 = [Adress2 stringByAppendingString: [NSString stringWithFormat:@"%@+", fad[i]]];
        };
        Adress2 = [Adress2 stringByAppendingString:@"Moscow"];
        [self recieve_coor];
        //переходн на след. view
        TagTable *gotoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondView2"];
        [gotoVC setUserCoordinates:UserCoordinates];
        [gotoVC setFriendCoordinates:FriendCoordinates];
        [gotoVC setMainPoint1:MainPoint1];
        [gotoVC setMainPoint2:MainPoint2];
        [self.navigationController pushViewController:gotoVC animated:YES];
    }
    
}

- (void)viewDidLoad {
    //вставить гифку
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wallpaper.png"]];
  //  [self.view addSubview:backgroundView];
    
self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wallpaper.png"]];
    self.view.alpha = 1;
    self.view.opaque = YES;
    //Не показывает error
    [self.errorLabel setHidden:YES];
    UIImage *btnImage = [UIImage imageNamed:@"check.png"];
    [self.CheckButton setImage:btnImage forState:UIControlStateNormal];
    btnImage = [UIImage imageNamed:@"plus.png"];
    [self.AddFriendButton setImage:btnImage forState:UIControlStateNormal];
    //Прячет плюс
    [self.AddFriendButton setHidden:YES];
//прячет navigation controller bar
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [super viewDidLoad];
    
}


    
#define kOFFSET_FOR_KEYBOARD 99.9

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if (([sender isEqual:FriendAdress])||([sender isEqual:UserAdress]))
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


/*-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-110,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,320,460)];
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
