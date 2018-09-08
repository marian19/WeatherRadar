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

NS_ASSUME_NONNULL_BEGIN

@interface WeatherInfo : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "WeatherInfo+CoreDataProperties.h"
