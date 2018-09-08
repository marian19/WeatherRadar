//
//  WeatherRemoteDataSource.m
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "WeatherRemoteDataSource.h"
#import "AFNetworkingClient.h"
#import "Constaints.h"

@implementation WeatherRemoteDataSource

AFNetworkingClient *httpClient;

- (id)init {
    self = [super init];
    if (self) {
        httpClient = [AFNetworkingClient sharedInstance];
    }
    return self;
}

-(void) getWeatherAt:(NSString*) cityName completion:(void (^)(Weather* _Nullable, NSError * _Nullable))completion{
    
    NSString *urlString  = [NSString stringWithFormat:kCityWeather, cityName];
    [httpClient GET: urlString withParameters:nil completion:^(id _Nullable response, NSError * _Nonnull error) {
        
        NSDictionary *responseDict = response;
        Weather *weather = [[Weather alloc] initWithNSDictionary:responseDict];
        
        completion(weather,nil);
    }];
}
@end
