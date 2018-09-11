//
//  WeatherDetailsPresenter.m
//  WeatherRadar
//
//  Created by Marian on 9/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "WeatherDetailsPresenter.h"
#import "WeatherRemoteDataSource.h"
#import "WeatherInfo.h"
#import "SVProgressHUD.h"
#import "Weather.h"
#import "Reachability.h"
#import "ErrorHandlingLayer.h"

@implementation WeatherDetailsPresenter

- (id)initWithView:(id < WeatherDetailsViewProtocol> )view {
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}

- (void)getWeatherDetailsforCity:(City *)city {
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable){
        
        [ErrorHandlingLayer handleErrorCode:INTERNET_CONNECTION];
        
    }else{
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[[WeatherRemoteDataSource alloc] init] getWeatherAt:city.name completion:^(Weather * weather, NSError * error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    
                    if (weather != nil){
                        
                        [self saveWeatherInfoToCoreData:weather forCity: city];
                        
                        [self.view showWeatherDetails:weather];
                    }
                });
            }];
            
        });
    }
}

- (void)saveWeatherInfoToCoreData:(Weather *)weather forCity:(City*)city {
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        WeatherInfo* weatherInfo = [WeatherInfo addCityWeatherInfo:weather toCity:city];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            if (weatherInfo == nil) {
                [ErrorHandlingLayer handleErrorCode:SAVE_ERROR];
            }
        });
    });
}

@end
