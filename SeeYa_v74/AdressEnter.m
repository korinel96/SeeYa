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

@implementation AdressEnter

//Данная функция формирует URL для оптправления запроса GOOGLE API, откуда будут получены координаты мест, где находятся собеседники
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

//Данная функция преобразует полученный JSON файл в массив мест и их координат.
-(void)fetchedData1:(NSData*) responseData: (int) side{
    NSError* error1;
    NSDictionary *json1 = [NSJSONSerialization
                           JSONObjectWithData:responseData
                           
                           options:kNilOptions
                           error:&error1];
    
    NSArray* places1 = [json1 objectForKey:@"results"];
    if ([places1 count] != 0)
    {
        if(side == 1)
        {
            FriendCoordinates = [NSMutableArray arrayWithObjects:
                    places1[0][@"geometry"][@"location"][@"lat"], places1[0][@"geometry"][@"location"][@"lng"], nil];
        }
        else
        {
            UserCoordinates = [NSMutableArray arrayWithObjects:
                    places1[0][@"geometry"][@"location"][@"lat"], places1[0][@"geometry"][@"location"][@"lng"], nil];
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
        ContainerView *gotoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondView"];
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
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
