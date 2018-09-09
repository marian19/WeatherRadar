//
//  NSString+ManipulateDate.m
//  WeatherRadar
//
//  Created by Marian on 9/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "NSDate+ManipulateDate.h"

@implementation NSDate (ManipulateDate)

-(NSString *)convertToString{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy - hh:mm"];
    return  [dateFormatter stringFromDate:self];
}
@end
