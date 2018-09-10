//
//  Weather.m
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "Weather.h"
#import "City.h"

@implementation Weather

-(instancetype)initWithNSDictionary : (NSDictionary*)dictionary{
    
    self = [super init];
    if (self) {
        
        self.city = [dictionary objectForKey:@"name"];
        NSArray *weather = (NSArray*) [dictionary objectForKey:@"weather"];
        self.weatherDescription = [weather[0] objectForKey:@"main"];
        self.icon = [weather[0] objectForKey:@"icon"];
        NSDictionary *weatherMain = [dictionary objectForKey:@"main"];
        self.temp = [[weatherMain objectForKey:@"temp"] doubleValue];
        self.humidity = [[weatherMain objectForKey:@"humidity"] doubleValue];
        NSDictionary *wind = [dictionary objectForKey:@"wind"];
        self.windSpeed = [[wind objectForKey:@"speed"] doubleValue];
        self.date = [NSDate date];
    }
    
    return self;
}

-(instancetype)initWithWeatherInfo: (WeatherInfo*)weatherInfo{
    
    self = [super init];
    if (self) {
        self.city = weatherInfo.city.name;
        self.weatherDescription = weatherInfo.weatherDescription;
        self.icon = weatherInfo.icon;
        self.temp = weatherInfo.temp;
        self.humidity = weatherInfo.humidity;
        self.windSpeed = weatherInfo.windSpeed;
        self.date = weatherInfo.date;
    }
    return self;
}
@end
