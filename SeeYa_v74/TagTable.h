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
}

@property (nonatomic, assign) NSInteger *tagNum;
@property(retain)  NSIndexPath* lastIndexPath;
@property (nonatomic, retain) NSArray *tags;

@end