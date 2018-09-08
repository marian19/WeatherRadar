//
//  Weather.h
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic) double temp;
@property (nonatomic) double humidity;
@property (nonatomic) double windSpeed;
@property (nonatomic, strong) NSDate *date;

-(instancetype)initWithNSDictionary : (NSDictionary*)dictionary;
@end
