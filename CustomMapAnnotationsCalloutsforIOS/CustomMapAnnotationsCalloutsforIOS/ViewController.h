//
//  ViewController.h
//  HBMapLibrary
//
//  Created by hb on 28/11/12.
//  Copyright (c) 2012 hb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
@interface ViewController : UIViewController<MapViewControllerDeligate>
@property(nonatomic,strong) MapViewController *mapControlller;
- (IBAction)buttonClicked:(id)sender;
@end
