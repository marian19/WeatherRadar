//
//  CitiesTableViewController.h
//  WeatherRadar
//
//  Created by Marian on 9/7/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "City.h"

@protocol CitiesViewProtocol <NSObject>
-(void)showCities:(NSArray<City*>*) cities;
@end

@interface CitiesTableViewController : BaseViewController <CitiesViewProtocol>

@end
