//
//  Weather+CoreDataClass.m
//  
//
//  Created by Marian on 9/8/18.
//
//

#import "WeatherInfo.h"
#import "Weather.h"
#import "CoreDataManager.h"
#import <UIKit/UIKit.h>

@implementation WeatherInfo

+(NSString*)entityName {
    return @"WeatherInfo";
}

+ (instancetype)addCityWeatherInfo:(Weather *)weather toCity:(City*)city{
    
    NSManagedObjectContext *managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext;
    
    WeatherInfo* weatherInfo = [NSEntityDescription
                                insertNewObjectForEntityForName:[WeatherInfo entityName]
                                inManagedObjectContext:managedObjectContext];
    weatherInfo.city = city;
    weatherInfo.temp = weather.temp;
    weatherInfo.windSpeed = weather.windSpeed;
    weatherInfo.date = weather.date;
    weatherInfo.weatherDescription = weather.weatherDescription;
    weatherInfo.icon = weather.icon;
    weatherInfo.humidity = weather.humidity;
    NSError *error = nil;
    [managedObjectContext save:&error];
    return weatherInfo;
}

+(NSArray<WeatherInfo *>*) getCityHistory:(City *)city{
    
    NSManagedObjectContext *managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"city == %@", city];
    NSFetchRequest *fetchRequest = [WeatherInfo fetchRequest];
    NSError *error = nil;
    [fetchRequest setPredicate:predicate];
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return results;
    
}
@end
