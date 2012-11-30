//
//  MapViewController.h
//  CustomMapAnnotationExample
//
//  Created by Hb on 27/11/12.
//  Copyright (c) 2012 HB 23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Place.h"
/*!
 The MapViewControllerDeligate class provides a platform for doing Map call back.
 @discussion MapViewControllerDeligate is used for doing Map call back functionality.
 */
@protocol MapViewControllerDeligate<NSObject>
@optional
/*!
 This method is using to handle callbacks from MapViewController to main calling viewController.
 @discussion This method is using to handle callbacks from MapViewController to main calling viewController.
 @param    place a Place object which represent that which place he clicked
 */
-(void)rightCalloutAccessoryViewClicked:(Place *)place;
@end

/*!
 The MapViewController class provides a platform for adding pings on Map.
 @discussion MapViewController is used for adding pings on Map view and handle click on detailed button event.And MKMapViewDelegate deligate of MKMapview
 */
@interface MapViewController : UIViewController<MKMapViewDelegate>
#pragma mark - MapViewController Properties 
/*!
 This property is the object for the MKMapView which is we need to show the user 
 */
@property (nonatomic, strong)MKMapView *mapView;
/*!
 This property is the object for the UILabel which represent the title of navigation bar
 */
@property (strong, nonatomic)UILabel *toolBarTitle;
/*!
 This property is the object for the UIImageView which represent the left Image view.We can custmise the UIImageView according to requirement
 */
@property(nonatomic,strong)UIImageView *leftCalloutAccessoryView;
/*!
 This property is the object for the UIButton which represent the right side Button default button type is UIButtonTypeDetailDisclosure.We can custmise the UIButton according to requirement
 */
@property(nonatomic,strong)UIButton *rightCalloutAccessoryView;
/*!
 This property is the object for the UILabel which represent the middle lable, Name of the place.We can custmise the UILabel look and feel like color,font etc according to requirement
 */
@property(nonatomic,strong)UILabel *titleView;
/*!
 This property is the object for the UILabel which represent the middle lable, details or sub title of the place.We can custmise the UILabel look and feel like color,font etc according to requirement
 */
@property(nonatomic,strong)UILabel *subTitleView;

#pragma mark - MapViewController init method
/*!
 This method init the MapViewController  and assign places,setting Deligate.
 @discussion This method init the MapViewController. initilizing all views  and assign places,setting Deligate.
 @param     places  A NSMutableArray specifying all places to show pins.
 @param     deligateObj A MapViewControllerDeligate specifying deligate
 @result    id a MapViewController object
 */
- (id)initWithPlaces:(NSMutableArray *)places AddDeligate:(id)deligateObj;

/*!
 This method used to hide navigation (tool)bar
 @discussion This method used to hide navigation (tool)bar.
*/
- (void)hideMapTopbar;

@end
