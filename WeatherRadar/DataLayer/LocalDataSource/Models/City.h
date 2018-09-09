//
//  City+CoreDataClass.h
//  
//
//  Created by Marian on 9/8/18.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WeatherInfo;

NS_ASSUME_NONNULL_BEGIN

@interface City : NSManagedObject

+ (BOOL)addCity:(NSString *)cityName;
+(City*) getCityWithName:(NSString *)cityName;
+(void)deleteCity:(City *)city;
+(NSArray<City *>*) getAllUserCities;

@end

NS_ASSUME_NONNULL_END

#import "City+CoreDataProperties.h"
