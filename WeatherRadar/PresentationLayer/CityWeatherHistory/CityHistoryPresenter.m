//
//  CitiesPresenter.m
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "CityHistoryPresenter.h"
#import "WeatherInfo.h"
#import "SVProgressHUD.h"

@implementation CityHistoryPresenter

- (id)initWithView:(id < CityHistoryViewProtocol> ) view {
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}


-(void)getCityHistory:(City*) city{
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSArray<WeatherInfo*> * weatherInfoArray = [WeatherInfo getCityHistory:city];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.view showCityHistory:weatherInfoArray];
        });
    });
}

@end
