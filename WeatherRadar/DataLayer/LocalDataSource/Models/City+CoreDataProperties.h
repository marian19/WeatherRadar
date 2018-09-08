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
@property (nullable, nonatomic, retain) WeatherInfo *weatherHistory;

@end

NS_ASSUME_NONNULL_END
