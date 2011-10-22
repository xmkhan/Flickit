//
//  PhotoTableViewController.m
//  FlickerPlacesCD
//
//  Created by Mohd Shahroze Khan on 11-08-04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoTableViewController.h"
#import "FlickrFetcher.h"
#import "Photo.h"
@implementation PhotoTableViewController
@synthesize context_;
-initWithStyle:(UITableViewStyle)style Context:(NSManagedObjectContext *)context Data:(NSArray *)data
{
    self = [super initWithStyle:style];
    if (self) {
        context_ = [context retain];
        //NSLog(@"%@",context_);
        data_ = [[NSArray alloc]initWithArray:data];
    }
    return self;
}

- (void)dealloc
{
   [data_ release];
    [context_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [data_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[data_ objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.detailTextLabel.text =[[[data_ objectAtIndex:indexPath.row]objectForKey:@"description"]objectForKey:@"_content"];
    
  //  cell.imageView.image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:[data_ objectAtIndex:indexPath.row] format:FlickrFetcherPhotoFormatThumbnail]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)sender{
    return  [sender.subviews objectAtIndex:0];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [Photo photoWithFlickrData:[data_ objectAtIndex:indexPath.row] inManagedObjectContext:context_];
    NSLog(@"%@",[[data_ objectAtIndex:indexPath.row]objectForKey:@"title"]);
    NSError *error=nil;
     [context_ save:&error];
    
    UIImage *image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:[data_ objectAtIndex:indexPath.row] format:FlickrFetcherPhotoFormatLarge]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image]; 
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    scrollView.bounces = NO;
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 3.0;
    [scrollView addSubview:imageView]; [imageView release];
    scrollView.delegate = self;
    [scrollView setContentSize:CGSizeMake(image.size.width, image.size.height)];
    [scrollView flashScrollIndicators];
    UIViewController *photo = [[UIViewController alloc]init]; 
    photo.view = scrollView;[scrollView release];
    [self.navigationController pushViewController:photo animated:YES];
    [photo release]; 
    
}

@end
