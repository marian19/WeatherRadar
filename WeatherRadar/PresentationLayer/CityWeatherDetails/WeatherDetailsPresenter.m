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

@implementation WeatherDetailsPresenter

- (id)initWithView:(id < WeatherDetailsViewProtocol> ) view {
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}
- (void)getWeatherDetailsforCity:(NSString *)cityName {
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [[[WeatherRemoteDataSource alloc] init] getWeatherAt:cityName completion:^(Weather * weather, NSError * error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
                if (error == nil){
                    [self.view showWeatherDetails:weather];
                }else{
                    [self.view showAlertWithText:@"WrongCityName"];
                }
            });
        }];
        
    });
}

- (void)saveWeatherInfo:(Weather *)weather andImage:(UIImage*) image {
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        WeatherInfo* weatherInfo = [WeatherInfo addCityWeatherInfo:weather icon:UIImagePNGRepresentation(image)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            if (weatherInfo != nil) {
                [self.view showAlertWithText:@"WeatherSaved"];
                
            }else{
                [self.view showAlertWithText:@"ErrorMessage"];
            }
        });
    });
}

@end
