//
//  AdressEnter.m
//  SeeYa_v74
//
//  Created by Sergey Im on 07/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import "AdressEnter.h"
#import <GoogleMaps/GoogleMaps.h>

@interface AdressEnter ()
@end

//NSString *KEY = @"AIzaSyAxYFweLCt2a10Hrxpk7hg5t-GGdbkc7fQ";
NSString *KEY = @"AIzaSyChBwHJcC-oiESi-7qJ6htfbz3ivtYSJTg";

@implementation AdressEnter

//Получение координат?(wut) назови переменные нормально
- (void) recieve_coor {
    NSString *url2 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&sensor=true&key=%@", Adress1, KEY];
    NSURL *googleRequestURL2=[NSURL URLWithString:[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData* data2 = [NSData dataWithContentsOfURL: googleRequestURL2];
    
    [self fetchedData1:data2:1];
    NSString *url3 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&sensor=true&key=%@", Adress2, KEY];
    NSURL *googleRequestURL3=[NSURL URLWithString:[url3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData* data3 = [NSData dataWithContentsOfURL: googleRequestURL3];
    [self fetchedData1:data3:2];
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
    
    NSArray* places = [json1 objectForKey:@"results"];
    if ([places count] != 0)
    {
        //NSLog(@"check1");
        if(side == 1)
        {
            FriendCoordinates = [NSMutableArray arrayWithObjects:
                    places[0][@"geometry"][@"location"][@"lat"], places[0][@"geometry"][@"location"][@"lng"], nil];
        }
        else
        {
            UserCoordinates = [NSMutableArray arrayWithObjects:
                    places[0][@"geometry"][@"location"][@"lat"], places[0][@"geometry"][@"location"][@"lng"], nil];
        }
    }
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
        ContainerView *gotoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondView2"];
        [self.navigationController pushViewController:gotoVC animated:YES];
    }
    
}

- (void)viewDidLoad {
    //вставить гифку
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
