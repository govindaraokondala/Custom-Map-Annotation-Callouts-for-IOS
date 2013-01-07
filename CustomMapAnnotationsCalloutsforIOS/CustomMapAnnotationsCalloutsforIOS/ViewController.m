//
//  ViewController.m
//  HBMapLibrary
//
//  Created by hb on 28/11/12.
//  Copyright (c) 2012 hb. All rights reserved.
//

#import "ViewController.h"
#import "Place.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize mapControlller;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    
    Place *p=[[Place alloc] init];
    p.placeName=@"Satyam Mall";
    p.placeDescription=@"Satellite Ahmedabad, Gujarat, India";
    p.latitude=23.029958;
    p.longitude=72.527615;
    p.isDisableRightCalloutAccessoryView=YES;
    p.placeImage=[UIImage imageNamed:@"satya.png"];
    
    
    Place *p1=[[Place alloc] init];
    p1.placeName=@"Courtyard Ahmedabad";
    p1.placeDescription=@"Ramdev Nagar Cross Road, Satellite Road";
    p1.latitude=23.027884;
    p1.longitude=72.511586;
    p1.placeImage=[UIImage imageNamed:@"count.png"];
    
    Place *p2=[[Place alloc] init];
    p2.placeName=@"Himalaya Mall";
    p2.placeDescription=@"Drive-in Rd, Gurukul Ahmedabad, Gujara";
    p2.latitude=23.046623;
    p2.longitude=72.531039;
    p2.placeImage=[UIImage imageNamed:@"hima.png"];
    
    NSMutableArray *placesArray=[[NSMutableArray alloc] init];
    
    [placesArray addObjectsFromArray:[NSArray arrayWithObjects:p,p1,p2, nil]];
    
    mapControlller=[[MapViewController alloc] initWithPlaces:placesArray AddDeligate:self];
//    mapControlller.titleView.textColor=[UIColor redColor];
//    [mapControlller hideMapTopbar];
    [self presentModalViewController:mapControlller animated:YES];
//    [self.navigationController pushViewController:mapControlller animated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
-(void)rightCalloutAccessoryViewClicked:(Place *)place;
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"selected place" message:[NSString stringWithFormat:@"title: %@ \n desc: %@ \n lat: %f \n lon: %f",place.placeName,place.placeDescription,place.latitude,place.longitude] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
