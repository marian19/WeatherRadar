//
//  WeatherDetailsPresenter.h
//  WeatherRadar
//
//  Created by Marian on 9/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "BasePresenter.h"
#import "Weather.h"
#import "WeatherDetailsViewController.h"

@protocol WeatherDetailsPresenterProtocol <NSObject>

-(void) getWeatherDetailsforCity:(NSString*) cityName;
-(void) saveWeatherInfo:(Weather *)weather andImage:(UIImage*) image;

@end

@interface WeatherDetailsPresenter : BasePresenter<WeatherDetailsPresenterProtocol>
- (id)initWithView:(id < WeatherDetailsViewProtocol> ) view;
@property (weak, nonatomic) id <WeatherDetailsViewProtocol> view;

@end
