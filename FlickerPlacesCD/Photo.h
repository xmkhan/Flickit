//
//  Photo.h
//  FlickerPlacesCD
//
//  Created by skhan on 11-07-30.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject {
@private
}
+ (Photo *)photoWithFlickrData:(NSDictionary *)flickrData inManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSData * imageSmall;
@property (nonatomic, retain) NSManagedObject *location;

@end
