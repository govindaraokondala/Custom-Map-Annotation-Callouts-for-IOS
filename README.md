Custom-Map-Annotation-Callouts-for-IOS
======================================
Demonstrates how to use the Maps and custom callouts. 
    
Build Requirements
iOS 4.0 SDK 


Runtime Requirements
iPhone OS 4.0 or later

Required folders for test application:
1)CustomMapLibraryClasses 

Required Extra Framework :

1)MapKit.framework


Required Delegate :

MapViewControllerDeligate

IMPORT STATEMENTS :

#import "MapViewController.h"
#import "Place.h"

How to use this sample
     
=====================******START OF USAGE*************====================================


STEP1:  CREATE ONE OBJECT FOR NSMutableArray
 
    NSMutableArray *placesArray=[[NSMutableArray alloc] init];
  
STEP2: CREATE AN OBJECT  FOR Place
    
    1)CREATE Places OBJECTS TO SHOW ON MAP
    
   	Place *p=[[Place alloc] init];
   	
   	2)SET PLACE NAME 
   	
    p.placeName=@"Satyam Mall";
    
    3)SET PLACE DESCRIPTION (OR SUB TITLE)
    
    p.placeDescription=@"Satellite Ahmedabad, Gujarat, India";
    
    4)SET LATITUDE OF PLACE
    
    p.latitude=23.029958;
    
    5)SET LONGITUDE OF PLACE
    
    p.longitude=72.527615;
    
    6)SET RightCalloutAccessoryView ON CALLOUT VIEW IS DISABLE OR NOT. DEFAULT IS ENABLE
    
    p.isDisableRightCalloutAccessoryView=YES;
    
    5)SET PLACE IMAGE TO SHOW ON LEFT SIDE OF CALLOUT VIEW
    
    p.placeImage=[UIImage imageNamed:@"satya.png"];
    
    6)FINALLY ADD THAT PLACE OBJECT(P) TO placesArray 
    
    [placesArray addObject:P];
    
 NOTE: REPETE ABOVE 6 STEPS AS PER YOUR NEED.HERE EACH PLACE OBJECT REPRESENT ONE PIN
   
    Place *p1=[[Place alloc] init];
    p1.placeName=@"Courtyard Ahmedabad";
    p1.placeDescription=@"Ramdev Nagar Cross Road, Satellite Road";
    p1.latitude=23.027884;
    p1.longitude=72.511586;
    p1.placeImage=[UIImage imageNamed:@"count.png"];
    [placesArray addObject:P1];
    
    Place *p2=[[Place alloc] init];
    p2.placeName=@"Himalaya Mall";
    p2.placeDescription=@"Drive-in Rd, Gurukul Ahmedabad, Gujara";
    p2.latitude=23.046623;
    p2.longitude=72.531039;
    p2.placeImage=[UIImage imageNamed:@"hima.png"];
    [placesArray addObject:P2];
    
    
STEP3:FINALLY CREATE OBJECT FOR MapViewController AS FOLLOWING ADD SET PLACES ARRY AND DELEGATE

	MapViewController *mapControlller=[[MapViewController alloc] initWithPlaces:placesArray AddDeligate:self];
     
     HERE YOOU CAN PRESENT MapViewController ON CURRENT VIEWCONTROLLER AS 
     	EX:[self presentModalViewController:mapControlller animated:YES];
     	
     	ELSE YOU CAN PUSH 
     	E:[self.navigationController pushViewController:mapControlller animated:YES];
    
OPTIONAL:
   
STEP4: IMPLEMENT DELEGATE METHOD

  -(void)rightCalloutAccessoryViewClicked:(Place *)place;
  {
  		//Do what ever you want
  }
  
STEP5:IF YOU WANT YOU CAN HIDE NAVIGATION BAR WHEN YOU PRESENT 
	
	[mapControlller hideMapTopbar];
	
STEP6:YOU CAN CUSTOMIZE TITLE LABLE, DESCRIPTION LABLE AND IMAGEVIEW AS PER OUR REQUIREMENT LIKE CHANGE COLOR , FONT ETC..

	EX:mapControlller.titleView.textColor=[UIColor redColor];

    
=============================================******END OF USAGE*************================================================ 

											************************************
											  WHAT IS INSIDE MapViewController								
											*************************************   




 This property is the object for the MKMapView which is we need to show the user 
 
 
	@property (nonatomic, strong)MKMapView *mapView;


 This property is the object for the UILabel which represent the title of navigation bar
 
 
	@property (strong, nonatomic)UILabel *toolBarTitle;


 This property is the object for the UIImageView which represent the left Image view.We can custmise the UIImageView according to requirement

 
	@property(nonatomic,strong)UIImageView *leftCalloutAccessoryView;


 This property is the object for the UIButton which represent the right side Button default button type is UIButtonTypeDetailDisclosure.We can custmise the UIButton according to requirement

 
	@property(nonatomic,strong)UIButton *rightCalloutAccessoryView;


 This property is the object for the UILabel which represent the middle lable, Name of the place.We can custmise the UILabel look and feel like color,font etc according to requirement

 
	@property(nonatomic,strong)UILabel *titleView;


 This property is the object for the UILabel which represent the middle lable, details or sub title of the place.We can custmise the UILabel look and feel like color,font etc according to requirement

	@property(nonatomic,strong)UILabel *subTitleView;



 This method init the MapViewController  and assign places,setting Deligate.
 @discussion This method init the MapViewController. initilizing all views  and assign places,setting Deligate.
 @param     places  A NSMutableArray specifying all places to show pins.
 @param     deligateObj A MapViewControllerDeligate specifying deligate
 @result    id a MapViewController object

 
	- (id)initWithPlaces:(NSMutableArray *)places AddDeligate:(id)deligateObj;


 This method used to hide navigation (tool)bar
 @discussion This method used to hide navigation (tool)bar.


	- (void)hideMapTopbar;




Changes from Previous Versions
1.0 - This id First release.

Copyright (C) 2012 http://govindaraokondala.blogspot.in/
