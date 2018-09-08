//
//  AFNetworkingClient.h
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetworkingClient : NSObject
+ (instancetype)sharedInstance;
- (void) GET:(NSString*)URLString withParameters:(NSDictionary*)parameter completion:(void (^)(id _Nullable, NSError * _Nonnull))completion;
@end
