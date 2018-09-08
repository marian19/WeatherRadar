//
//  WeatherRemoteDataSource.h
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface WeatherRemoteDataSource : NSObject

-(void) getWeatherAt:(NSString*) cityName completion:(void (^)(Weather * _Nullable, NSError * _Nullable))completion;

@end
