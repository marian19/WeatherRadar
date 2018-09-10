//
//  WeatherDetailsPresenter.h
//  WeatherRadar
//
//  Created by Marian on 9/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "BasePresenter.h"
#import "WeatherDetailsViewController.h"
#import "City.h"
@protocol WeatherDetailsPresenterProtocol <NSObject>

- (void)getWeatherDetailsforCity:(City *)city;

@end

@interface WeatherDetailsPresenter : BasePresenter<WeatherDetailsPresenterProtocol>

- (id)initWithView:(id < WeatherDetailsViewProtocol> ) view;
@property (weak, nonatomic) id <WeatherDetailsViewProtocol> view;

@end
