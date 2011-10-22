//
//  FlickerPlacesCDAppDelegate.h
//  FlickerPlacesCD
//
//  Created by Mohd Shahroze Khan on 11-07-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface FlickerPlacesCDAppDelegate : NSObject <UIApplicationDelegate,FBSessionDelegate> { 
    UITabBarController *tbc;
    Facebook *facebook;
}
@property (nonatomic,retain) Facebook *facebook;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void)deleteCoreData;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
