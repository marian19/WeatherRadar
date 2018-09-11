//
//  ErrorHandlingLayer.m
//  SearchManger.m
//
//  Created by Marian on 12/7/16.
//  Copyright © 2016 Marian. All rights reserved.
//


#import "ErrorHandlingLayer.h"

@implementation ErrorHandlingLayer

static UIAlertController *errorMessageAlertView;

static const NSInteger INVALID_API_KEY  =   401;
static const NSInteger INVALID_CITY_NAME = 404;


+(void)handleErrorCode:(NSInteger)statusCode
{
    NSString *errorMessage =@"ErrorMessage";
    
    switch (statusCode){
            
            case INVALID_CITY_NAME:
            errorMessage = @"WrongCityName";
            break;
            
            case INVALID_API_KEY:
            errorMessage = @"WrongAPI";
            break;
            
            
            case INTERNET_CONNECTION:
            errorMessage = @"CheckConnection";
            break;
            
            case DUPLICATE_CITY_ERROR:
            errorMessage = @"CityIsExist";
            break;
            
        default:
            break;
    }
    [ErrorHandlingLayer handleErrorWithMessage:errorMessage];
}


+(void)handleErrorWithMessage:(NSString*)message
{
    
    errorMessageAlertView = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(message,nil) preferredStyle:UIAlertControllerStyleAlert];
    [errorMessageAlertView addAction: [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:nil]];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    UIViewController *mainController = [keyWindow rootViewController];
    [mainController presentViewController:errorMessageAlertView animated:YES completion:nil];
    
    
}




@end
