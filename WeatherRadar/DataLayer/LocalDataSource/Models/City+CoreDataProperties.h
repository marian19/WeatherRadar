//
//  City+CoreDataProperties.h
//  
//
//  Created by Marian on 9/8/18.
//
//

#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

+ (NSFetchRequest<City *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<WeatherInfo *> *weatherHistory;

@end

@interface City (CoreDataGeneratedAccessors)

- (void)addWeatherHistoryObject:(WeatherInfo *)value;
- (void)removeWeatherHistoryObject:(WeatherInfo *)value;
- (void)addWeatherHistory:(NSSet<WeatherInfo *> *)values;
- (void)removeWeatherHistory:(NSSet<WeatherInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
