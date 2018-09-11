//
//  ErrorHandlingLayer.h
//  SearchManger.m
//
//  Created by Marian on 12/7/16.
//  Copyright © 2016 Marian. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const NSInteger INTERNET_CONNECTION= -100;
static const NSInteger SAVE_ERROR= -80;
static const NSInteger DUPLICATE_CITY_ERROR= -50;

@interface ErrorHandlingLayer : NSObject <UIAlertViewDelegate>

+(void)handleErrorCode:(NSInteger)statusCode;

@end
