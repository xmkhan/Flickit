//
//  PhotoTableViewController.h
//  FlickerPlacesCD
//
//  Created by Mohd Shahroze Khan on 11-08-04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PhotoTableViewController : UITableViewController {
    NSManagedObjectContext *context_;
    NSArray *data_;
}
-initWithStyle:(UITableViewStyle)style Context:(NSManagedObjectContext *)context Data:(NSArray *)data;
@property (nonatomic,retain) NSManagedObjectContext *context_;
@end
