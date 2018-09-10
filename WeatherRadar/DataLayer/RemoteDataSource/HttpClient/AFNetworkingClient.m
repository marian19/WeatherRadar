//
//  AFNetworkingClient.m
//  WeatherRadar
//
//  Created by Marian on 9/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "AFNetworkingClient.h"
#import "AFNetworking.h"
#import "Constaints.h"

@implementation AFNetworkingClient

+ (instancetype)sharedInstance{
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void) GET:(NSString*)URLString withParameters:(NSDictionary*)parameter completion:(void (^)(id _Nullable, NSError * _Nullable))completion{
    
    NSString* fullURLString = [NSString stringWithFormat:kBaseURL,URLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:fullURLString parameters:parameter progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        completion(responseObject, nil);
        [manager invalidateSessionCancelingTasks:YES];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completion(nil, error);
        [manager invalidateSessionCancelingTasks:YES];
        
    }];
}

- (void) downloadImage:(NSString*)icon completion:(void (^)(UIImage *  _Nullable, NSError * _Nullable))completion{
    
    NSString* fullURLString = [NSString stringWithFormat:kIconsBaseURL,icon];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: fullURLString]];
    
    [[AFImageDownloader defaultInstance] downloadImageForURLRequest:request success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        completion(nil, error);
        
    }];
    
}
@end
