//
//  PlaceTableViewController.h
//  FlickerPlacesCD
//
//  Created by Mohd Shahroze Khan on 11-08-02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PlaceTableViewController : UITableViewController {
    NSManagedObjectContext *context_;
    NSArray *data_;     
}
- initWithStyle:(UITableViewStyle)style Context:(NSManagedObjectContext *)context;
@end
