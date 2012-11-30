//
//  Place.h
//  iTransitBuddy
//
//  Created by Blue Technology Solutions LLC 09/09/2008.
//  Copyright 2010 Blue Technology Solutions LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Place : NSObject {

	NSString* placeName;
	NSString* placeDescription;
	double latitude;
	double longitude;
    UIImage *placeImage;
    
}
@property(nonatomic) BOOL isDisableRightCalloutAccessoryView;
@property (nonatomic, retain) NSString* placeName;
@property (nonatomic, retain) NSString* placeDescription;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic,strong) UIImage *placeImage;
@end
