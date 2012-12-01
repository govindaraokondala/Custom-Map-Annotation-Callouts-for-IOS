//
//  MapViewController.m
//  CustomMapAnnotationExample
//
//  Created by Hb on 27/11/12.
//  Copyright (c) 2012 HB 23. All rights reserved.
//

#import "MapViewController.h"
#import "CalloutMapAnnotationView.h"
#import "PlaceMark.h"
#define deviceWidthInPortrate [[UIScreen mainScreen] bounds].size.width
#define deviceHeightInPortrate [[UIScreen mainScreen] bounds].size.height
#define deviceWidthInLandScape [[UIScreen mainScreen] bounds].size.height
#define deviceHeightInLandScape [[UIScreen mainScreen] bounds].size.width
@interface MapViewController ()
@property (nonatomic, retain) PlaceMark *placeMarkAnnotation;

@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;
@property(nonatomic,strong) NSMutableArray *placesArray;
@property(nonatomic,retain)UIView *customAnnotationView;
@property(nonatomic,strong)id <MapViewControllerDeligate> mapdeligate;
@property (strong, nonatomic) UIToolbar *mapToolBar;
@property(nonatomic,strong)CalloutMapAnnotationView *calloutMapAnnotationView;

- (void)CancelClicked:(id)sender;
-(void)setFramesAccordingtoOrientation:(UIInterfaceOrientation)orientation;
-(void)tapedOnDetailDislusureView;
-(BOOL)isModal;
@end

@implementation MapViewController
@synthesize placeMarkAnnotation;
@synthesize mapView ;
@synthesize selectedAnnotationView ;
@synthesize calloutMapAnnotationView;
@synthesize customAnnotationView;
@synthesize mapdeligate;
@synthesize placesArray;
@synthesize leftCalloutAccessoryView;
@synthesize rightCalloutAccessoryView;
@synthesize subTitleView;
@synthesize titleView;
@synthesize toolBarTitle;
@synthesize mapToolBar;

#pragma mark - init 
- (id)initWithPlaces:(NSMutableArray *)places AddDeligate:(id)deligateObj
{
    self = [super init];//longitude and latitude
    if (self) {
        self.placesArray=places;
        self.mapdeligate=deligateObj;
        self.customAnnotationView=[[UIView alloc] init];
        
        //UIImage
        self.leftCalloutAccessoryView=[[UIImageView alloc] init];
        self.leftCalloutAccessoryView.tag=1;
        [self.leftCalloutAccessoryView setBackgroundColor:[UIColor clearColor]];
        [self.customAnnotationView addSubview:self.leftCalloutAccessoryView];
        
        //Title
        self.titleView=[[UILabel alloc] init];
        self.titleView.tag=2;
        //self.titleView.textAlignment=UITextAlignmentCenter;
        //titleLbl.text=self.calloutAnnotation.place.name;
        [self.titleView setBackgroundColor:[UIColor clearColor]];
        self.titleView.textColor=[UIColor whiteColor];
        self.titleView.shadowColor=[UIColor grayColor];
        self.titleView.shadowOffset=CGSizeMake(0, -1);
        self.titleView.font=[UIFont boldSystemFontOfSize:17.0];
        [self.customAnnotationView addSubview:self.titleView];
        
        //Description
        self.subTitleView=[[UILabel alloc] init];
        self.subTitleView.tag=3;
        //self.subTitleView.textAlignment=UITextAlignmentCenter;
        // descLbl.text=self.calloutAnnotation.place.description;
        self.subTitleView.textColor=[UIColor whiteColor];
        [self.subTitleView setBackgroundColor:[UIColor clearColor]];
        [self.customAnnotationView addSubview:self.subTitleView];
        
        //Detail Button
        self.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //[self.rightCalloutAccessoryView addTarget:self action:@selector(clickedOnDetailedDiscButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.customAnnotationView addSubview:self.rightCalloutAccessoryView];
        [self.rightCalloutAccessoryView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedOnDetailDislusureView)]];
        
        self.toolBarTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        //self.toolBarTitle.autoresizingMask =   UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth  | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.toolBarTitle.textColor=[UIColor whiteColor];
        self.toolBarTitle.shadowColor=[UIColor grayColor];
        self.toolBarTitle.shadowOffset=CGSizeMake(0, -1);
        self.toolBarTitle.font=[UIFont boldSystemFontOfSize:17.0];
        self.toolBarTitle.text=@"Maps";
        self.toolBarTitle.backgroundColor=[UIColor clearColor];
        
        
        self.mapView=[[MKMapView alloc] initWithFrame:CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        self.mapToolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
        self.mapToolBar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth  | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.mapToolBar.tintColor=[UIColor blackColor];

    }
    return self;
}
#pragma mark - hide the tool bar 
-(void)hideMapTopbar
{
    self.mapToolBar.hidden=YES;
    self.toolBarTitle.hidden=YES;
    self.mapView.frame=CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height+50);
}
#pragma mark - Viewcontroller methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate=self;
    [self.view addSubview:self.mapView];
    
        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(CancelClicked:)];
    [self.mapToolBar setItems:[NSArray arrayWithObject:cancelButton]];
    
    self.toolBarTitle.textAlignment=UITextAlignmentCenter;
    [self.mapToolBar addSubview:self.toolBarTitle];
    [self.view addSubview:self.mapToolBar];
    [self.view addSubview:self.mapView];
    
    
    MKCoordinateRegion region;
	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 120;
	CLLocationDegrees minLon = 150;
    
    for(int i=0;i<[self.placesArray count];i++)
    {
        Place *home=(Place *)[self.placesArray objectAtIndex:i];
        PlaceMark *customAnnotation = [[PlaceMark alloc] initWithPlace:home] ;
        [self.mapView addAnnotation:customAnnotation];
		CLLocation* currentLocation = (CLLocation*)customAnnotation ;
		if(currentLocation.coordinate.latitude > maxLat)
			maxLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.latitude < minLat)
			minLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.longitude > maxLon)
			maxLon = currentLocation.coordinate.longitude;
		if(currentLocation.coordinate.longitude < minLon)
			minLon = currentLocation.coordinate.longitude;
		
		region.center.latitude     = (maxLat + minLat) / 2;
		region.center.longitude    = (maxLon + minLon) / 2;
		region.span.latitudeDelta  =  maxLat - minLat;
		region.span.longitudeDelta = maxLon - minLon;
        [self.mapView setRegion:region animated:YES];
    }
//   	[self.mapView setRegion:region animated:YES];
    [self setFramesAccordingtoOrientation:[UIApplication sharedApplication].statusBarOrientation];
    if(![self isModal])
        [self hideMapTopbar];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self setFramesAccordingtoOrientation:toInterfaceOrientation];
}
#pragma mark - set frames according to device
-(void)setFramesAccordingtoOrientation:(UIInterfaceOrientation )orientation
{
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        self.toolBarTitle.frame=CGRectMake(0, 0, deviceWidthInPortrate, 44);
    }else{
        self.toolBarTitle.frame=CGRectMake(0, 0, deviceWidthInLandScape, 44);
    }
    if(self.selectedAnnotationView==nil||calloutMapAnnotationView==nil)
        return;
    [self.mapView removeAnnotation: self.placeMarkAnnotation];
    calloutMapAnnotationView=nil;
    [self mapView:self.mapView didSelectAnnotationView:self.selectedAnnotationView];
}
#pragma mark - Map view deligate methods

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
//    NSLog(@"view: %@",view.description);
    if(calloutMapAnnotationView!=nil)
    {
        [self.mapView removeAnnotation: self.placeMarkAnnotation];
        calloutMapAnnotationView=nil;
    }
    if (self.placeMarkAnnotation == nil) {
        self.placeMarkAnnotation = [[PlaceMark alloc] initWithPlace:((PlaceMark *)view.annotation).place];
        
    } else {
        [self.placeMarkAnnotation setCoordinate:view.annotation.coordinate];
        [self.placeMarkAnnotation setPlace:((PlaceMark *)view.annotation).place];
    }
    self.selectedAnnotationView = view;
    [self.mapView addAnnotation:self.placeMarkAnnotation];
}
//
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if(calloutMapAnnotationView==nil)
        return;
    
    [self.mapView removeAnnotation: self.placeMarkAnnotation];
    calloutMapAnnotationView=nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
  	if (annotation == self.placeMarkAnnotation) {
        calloutMapAnnotationView = [[CalloutMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"hi"] ;
        calloutMapAnnotationView.contentHeight = 78.0f;
        [calloutMapAnnotationView.contentView addSubview:self.customAnnotationView];
        self.customAnnotationView.frame=CGRectMake(5, 0, 320-20, 78.0f);
        if(self.placeMarkAnnotation.place.placeImage!=nil)
        {
            self.leftCalloutAccessoryView.hidden=NO;
            self.rightCalloutAccessoryView.hidden=NO;
            self.titleView.textAlignment=UITextAlignmentLeft;
            self.subTitleView.textAlignment=UITextAlignmentLeft;
           ((UIImageView *)[self.customAnnotationView viewWithTag:1]).image=self.placeMarkAnnotation.place.placeImage;
            self.leftCalloutAccessoryView.frame=CGRectMake(2, 2, 72, 72);
            self.titleView.frame=CGRectMake(80, 13, 320-20-80-30, 21);
            self.subTitleView.frame=CGRectMake(80, 42, 320-20-80-30, 21);
            self.rightCalloutAccessoryView.frame=CGRectMake(320-20-30-3, 22, 29, 31);
        }else{
            self.leftCalloutAccessoryView.hidden=YES;
            self.titleView.frame=CGRectMake(5, 13, 320-20-80-30, 21);
            self.titleView.textAlignment=UITextAlignmentCenter;
            self.subTitleView.textAlignment=UITextAlignmentCenter;
            self.subTitleView.frame=CGRectMake(5, 42, 320-20-80-30, 21);
            self.rightCalloutAccessoryView.frame=CGRectMake(320-20-30-3, 22, 29, 31);
        }
        if(self.placeMarkAnnotation.place.isDisableRightCalloutAccessoryView)
        {
            self.rightCalloutAccessoryView.hidden=YES;
            if(self.placeMarkAnnotation.place.placeImage!=nil)
            {
                self.titleView.textAlignment=UITextAlignmentLeft;
                self.subTitleView.textAlignment=UITextAlignmentLeft;
                ((UIImageView *)[self.customAnnotationView viewWithTag:1]).image=self.placeMarkAnnotation.place.placeImage;
                self.leftCalloutAccessoryView.frame=CGRectMake(2, 2, 72, 72);
                self.titleView.frame=CGRectMake(80, 13, 320-20-80, 21);
                self.subTitleView.frame=CGRectMake(80, 42, 320-20-80, 21);
             }else{
                self.leftCalloutAccessoryView.hidden=YES;
                self.titleView.frame=CGRectMake(0, 13, 320-20, 21);
                self.titleView.textAlignment=UITextAlignmentCenter;
                self.subTitleView.textAlignment=UITextAlignmentCenter;
                self.subTitleView.frame=CGRectMake(0, 42, 320-20, 21);
            }
        }
        ((UILabel *)[self.customAnnotationView viewWithTag:2]).text=self.placeMarkAnnotation.place.placeName;
        ((UILabel *)[self.customAnnotationView viewWithTag:3]).text=self.placeMarkAnnotation.place.placeDescription;
        
        calloutMapAnnotationView.parentAnnotationView = self.selectedAnnotationView;
		calloutMapAnnotationView.mapView = self.mapView;
        return calloutMapAnnotationView;
	} else {
        
		MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnotation"] ;
        annotationView.animatesDrop=YES;
        annotationView.canShowCallout = NO;
		annotationView.pinColor = MKPinAnnotationColorRed;
//        annotationView.image=[UIImage imageNamed:@"pin.png"];
        return annotationView;
        
//        MKAnnotationView *tmpView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
//        tmpView.frame=CGRectMake(-8,-34, 32, 39);
//        tmpView.tag = [annotation.title intValue];
//        tmpView.image  = [UIImage imageNamed:@"pin.png"];
//        NSLog(@"View: %@",tmpView.description);
//        return tmpView;
    }
	return nil;
}
#pragma mark - callback methods
- (void)CancelClicked:(id)sender {
    if([self isModal])
        [self dismissModalViewControllerAnimated:YES];
    else
        [self.navigationController popToRootViewControllerAnimated:YES];
    self.placeMarkAnnotation=nil;
    self.mapView =nil;
    self.selectedAnnotationView =nil;
    self.calloutMapAnnotationView=nil;
    self.customAnnotationView=nil;
    self.mapdeligate=nil;
    self.placesArray=nil;
    self.leftCalloutAccessoryView=nil;
    self.rightCalloutAccessoryView=nil;
    self.subTitleView=nil;
    self.titleView=nil;
    self.toolBarTitle=nil;
    self.mapToolBar=nil;
}

-(void)tapedOnDetailDislusureView
{
    if(self.mapdeligate!=nil && [self.mapdeligate respondsToSelector:@selector(rightCalloutAccessoryViewClicked:)])
    {
        [self.mapdeligate rightCalloutAccessoryViewClicked:self.placeMarkAnnotation.place];
    }
    [self CancelClicked:nil];
}
-(BOOL)isModal {
    
    BOOL isModal = ((self.parentViewController && self.parentViewController.modalViewController == self) ||
                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                    ( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.modalViewController == self.navigationController) ||
                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                    [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
    
    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        
        isModal = ((self.presentingViewController && self.presentingViewController.modalViewController == self) ||
                   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.modalViewController == self.navigationController) ||
                   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
        
    }
    
    return isModal;        
    
}
@end
