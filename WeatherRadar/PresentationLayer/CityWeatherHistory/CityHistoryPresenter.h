//
//  CitiesPresenter.h
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "BasePresenter.h"
#import "City.h"
#import "CityHistoryTableViewController.h"

@protocol CityHistoryPresenterProtocol <NSObject>

-(void)getCityHistory:(City*) city ;

@end

@interface CityHistoryPresenter : BasePresenter<CityHistoryPresenterProtocol>

- (id)initWithView:(id < CityHistoryViewProtocol> ) view;
@property (weak, nonatomic) id <CityHistoryViewProtocol> view;

@end
