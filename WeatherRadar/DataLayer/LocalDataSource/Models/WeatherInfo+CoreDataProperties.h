//
//  Weather+CoreDataProperties.h
//  
//
//  Created by Marian on 9/8/18.
//
//

#import "WeatherInfo.h"


NS_ASSUME_NONNULL_BEGIN

@interface WeatherInfo (CoreDataProperties)

+ (NSFetchRequest<WeatherInfo *> *)fetchRequest;

@property (nonatomic) double temp;
@property (nonatomic) double windSpeed;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *weatherDescription;
@property (nullable, nonatomic, copy) NSString *icon;
@property (nonatomic) double humidity;
@property (nullable, nonatomic, retain) City *city;

@end

NS_ASSUME_NONNULL_END
