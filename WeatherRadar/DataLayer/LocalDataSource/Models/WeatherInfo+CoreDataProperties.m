//
//  Weather+CoreDataProperties.m
//  
//
//  Created by Marian on 9/8/18.
//
//

#import "WeatherInfo+CoreDataProperties.h"

@implementation WeatherInfo (CoreDataProperties)

+ (NSFetchRequest<WeatherInfo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Weather"];
}

@dynamic temp;
@dynamic windSpeed;
@dynamic date;
@dynamic weatherDescription;
@dynamic icon;
@dynamic humidity;
@dynamic city;

@end
