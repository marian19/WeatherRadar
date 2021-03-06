//
//  WeatherDetailsViewController.h
//  WeatherRadar
//
//  Created by Marian on 9/7/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Weather.h"
#import "City.h"

@protocol WeatherDetailsViewProtocol <NSObject>

-(void)showWeatherDetails:(Weather*) weatherDetails;
-(void)showAlertWithText:(NSString*) text;

@end

@interface WeatherDetailsViewController : BaseViewController<WeatherDetailsViewProtocol>

@property (strong, nonatomic) City *city;
@property (strong, nonatomic) Weather *weather;

@end
