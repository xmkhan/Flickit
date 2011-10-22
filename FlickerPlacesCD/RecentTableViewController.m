//
//  RecentTableViewController.m
//  FlickerPlacesCD
//
//  Created by Mohd Shahroze Khan on 11-08-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecentTableViewController.h"
#import "Photo.h"

@implementation RecentTableViewController
-(id)initWithContext: (NSManagedObjectContext *)context{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self){
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        request.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO selector:@selector(caseInsensitiveCompare:)]];
        
        request.predicate = nil;
		request.fetchBatchSize = 20;
        [NSFetchedResultsController deleteCacheWithName:@"MyPhotoCache"];
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:request
                                           managedObjectContext:context
                                           sectionNameKeyPath:nil
                                           cacheName:nil];
		[request release];
		
		self.fetchedResultsController = frc;
		[frc release];
		
		self.titleKey = @"name";
        self.subtitleKey =@"detail";
    }
    return self;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)sender{
    return  [sender.subviews objectAtIndex:0];
}
- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
Photo *photo = (Photo *)managedObject;
    
    UIImage *image = [UIImage imageWithData:photo.image];
   UIImageView *imageView = [[UIImageView alloc] initWithImage:image]; 
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    scrollView.bounces = NO;
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 3.0;
    [scrollView addSubview:imageView]; [imageView release];
    scrollView.delegate = self;
   [scrollView setContentSize:CGSizeMake(image.size.width, image.size.height)];
    [scrollView flashScrollIndicators];
    UIViewController *photoVIEW = [[UIViewController alloc]init]; 
    photoVIEW.view = scrollView;[scrollView release];
    [self.navigationController pushViewController:photoVIEW animated:YES];
    [photoVIEW release]; 
}

@end
