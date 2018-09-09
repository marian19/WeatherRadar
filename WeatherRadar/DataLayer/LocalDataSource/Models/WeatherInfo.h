//
//  Weather+CoreDataClass.h
//  
//
//  Created by Marian on 9/8/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Weather.h"
@class City;

NS_ASSUME_NONNULL_BEGIN

@interface WeatherInfo : NSManagedObject
+ (instancetype)addCityWeatherInfo:(Weather *)weather icon:(NSData*) imageData;
@end

NS_ASSUME_NONNULL_END

#import "WeatherInfo+CoreDataProperties.h"
