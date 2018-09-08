//
//  CitiesPresenter.h
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "BasePresenter.h"
#import "City.h"

@protocol CitiesPresenterProtocol <NSObject>
-(void) getCities;
-(void) deleteCity:(City*) city;
@end

@interface CitiesPresenter : BasePresenter<CitiesPresenterProtocol>

@end
