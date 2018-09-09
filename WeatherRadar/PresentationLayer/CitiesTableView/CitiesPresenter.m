//
//  CitiesPresenter.m
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "CitiesPresenter.h"
#import "City.h"

@implementation CitiesPresenter

- (id)initWithView:(id < CitiesViewProtocol> ) view {
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}
- (void)deleteCity:(City *)city {
    
    [City deleteCity:city];
}

- (void)getCities {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSArray<City*> * cities = [City getAllUserCities];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view showCities:cities];
        });
    });
}

-(void) addCity:(NSString*) cityName{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       BOOL isCityExist = [City addCity:cityName];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isCityExist) {
                [self.view showAlertWithText:@"CityIsExist"];
            }else{
                [self.view showAlertWithText:@"CityAdded"];

            }
        });
    });
}

@end
