//
//  RecentTableViewController.h
//  FlickerPlacesCD
//
//  Created by Mohd Shahroze Khan on 11-08-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataTableViewController.h"

@interface RecentTableViewController : CoreDataTableViewController {
}
-(id)initWithContext: (NSManagedObjectContext *)context;
@end
