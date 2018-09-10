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
#import "WeatherInfo.h"

@protocol CityHistoryViewProtocol <NSObject>

-(void)showCityHistory:(NSArray<WeatherInfo*>*) weatherInfoArray;
-(void)showAlertWithText:(NSString*) text;

@end

@interface CityHistoryTableViewController : BaseViewController <CityHistoryViewProtocol>

@property (strong, nonatomic) City* city ;

@end
