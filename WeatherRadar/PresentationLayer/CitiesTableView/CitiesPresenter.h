//
//  CitiesPresenter.h
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "BasePresenter.h"
#import "City.h"
#import "CitiesTableViewController.h"

@protocol CitiesPresenterProtocol <NSObject>

-(void)getCities;
-(void)deleteCity:(City*) city;
-(void)addCity:(NSString*) cityName;

@end

@interface CitiesPresenter : BasePresenter<CitiesPresenterProtocol>

- (id)initWithView:(id < CitiesViewProtocol> ) view;
@property (weak, nonatomic) id <CitiesViewProtocol> view;

@end
