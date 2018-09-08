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


+ (instancetype)addCityWeatherInfo:(Weather *)weather icon:(NSData*) imageData{
    
    NSManagedObjectContext *managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext;
    
    WeatherInfo* weatherInfo = [NSEntityDescription
                                insertNewObjectForEntityForName:[WeatherInfo entityName]
                                inManagedObjectContext:managedObjectContext];
    
    weatherInfo.temp = weather.temp;
    weatherInfo.windSpeed = weather.windSpeed;
    weatherInfo.date = weather.date;
    weatherInfo.weatherDescription = weather.weatherDescription;
    weatherInfo.icon = imageData;
    weatherInfo.humidity = weather.humidity;
    NSError *error = nil;
    [managedObjectContext save:&error];
    return weatherInfo;
}

@end
