//
//  Photo.m
//  FlickerPlacesCD
//
//  Created by skhan on 11-07-30.
//  Copyright (c) 2011 Khan. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"

@implementation Photo

+ (Photo *)photoWithFlickrData:(NSDictionary *)flickrData inManagedObjectContext:(NSManagedObjectContext *)context{
    Photo *photo = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueID = %@",[flickrData objectForKey:@"id"]];
    NSError *error= nil;
   /* NSArray *fetchResult = [NSArray arrayWithArray:[context executeFetchRequest:request error:&error]];
    if ([fetchResult count] > 10){
        [context deleteObject:[fetchResult objectAtIndex:0]];
    }*/
    
    photo = [[context executeFetchRequest:request error:&error]lastObject];
    [request release];
    if(!error && !photo){
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.uniqueID = [flickrData objectForKey:@"id"];
        photo.detail = [[flickrData objectForKey:@"description"]objectForKey:@"_content"];
        photo.date = [flickrData objectForKey:@"date"];
        photo.name = [flickrData objectForKey:@"title"];
        NSLog(@"%@",[flickrData objectForKey:@"title"]);
        photo.imageURL = [FlickrFetcher urlStringForPhotoWithFlickrInfo:flickrData format:FlickrFetcherPhotoFormatLarge];
        photo.image = [FlickrFetcher imageDataForPhotoWithURLString:photo.imageURL];
        //photo.imageSmall = [FlickrFetcher imageDataForPhotoWithFlickrInfo:flickrData format:FlickrFetcherPhotoFormatThumbnail];
    }
    
    return photo;  
}
- (NSString *)firstLetterOfName
{
	return [[self.name substringToIndex:1] capitalizedString];
}
@dynamic uniqueID;
@dynamic detail;
@dynamic date;
@dynamic name;
@dynamic image;
@dynamic imageURL;
@dynamic imageSmall;
@dynamic location;

@end
