//
//  TagTable.m
//  SeeYa_v74
//
//  Created by Sergey Im on 08/04/15.
//  Copyright (c) 2015 Sergey Im. All rights reserved.
//

#import "TagTable.h"
#import <Foundation/Foundation.h>
#import "Global.h"

@implementation TagTable
@synthesize tags;
@synthesize tagNum;

- (void)viewDidLoad {
    self.title = @"Tags";
    //Нужно увеличить кол-во статических ячеек в storyboard при добавлении тегов
    self.tags = [NSArray arrayWithObjects:@"Meal",/*@"cafe",@"restaurant", @"bakery", @"meal_takeaway",*/ @"Store",@"Library",@"Night Club",@"Museum",@"Park", nil];
    TagString = @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        switch(indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"meal.png"];                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"store.png"];                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"library.png"];                break;
            case 3:
                cell.imageView.image = [UIImage imageNamed:@"nightclub.png"];                break;
            case 4:
                cell.imageView.image = [UIImage imageNamed:@"museum.png"];                break;
            case 5:
                cell.imageView.image = [UIImage imageNamed:@"park.png"];                break;
            default:
                break;
        }
    }
    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    // иначе возможна только одна галочка
    /*else
     {
     cell.accessoryType = UITableViewCellAccessoryNone;
     }
     */
    cell.textLabel.text = [tags objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.lastIndexPath = indexPath;
    [tableView reloadData];
    
    switch(indexPath.row) {
        case 0:
            TagString = [TagString stringByAppendingString:@"cafe&restaurant&"];
            break;
        case 1:
            TagString = [TagString stringByAppendingString:@"store&"];
            break;
        case 2:
            TagString = [TagString stringByAppendingString:@"library&"];
            break;
        case 3:
            TagString = [TagString stringByAppendingString:@"night_club&"];
        case 4:
            TagString = [TagString stringByAppendingString:@"museum&"];
            break;
        case 5:
            TagString = [TagString stringByAppendingString:@"park&"];
            break;
        default:
            break;
            // do something by default;
    }
    
    
    
}
@end
