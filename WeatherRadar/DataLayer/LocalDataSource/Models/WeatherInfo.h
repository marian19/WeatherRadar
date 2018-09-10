//
//  Weather+CoreDataClass.h
//  
//
//  Created by Marian on 9/8/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City;
@class Weather;
NS_ASSUME_NONNULL_BEGIN

@interface WeatherInfo : NSManagedObject
+ (instancetype)addCityWeatherInfo: (Weather*)weather toCity:(City*)city;

+(NSArray<WeatherInfo *>*) getCityHistory:(City *)city;
@end

NS_ASSUME_NONNULL_END

#import "WeatherInfo+CoreDataProperties.h"
