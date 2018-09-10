//
//  UIImageView+Download.m
//  WeatherRadar
//
//  Created by Marian on 9/10/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "UIImageView+Download.h"
#import "AFNetworkingClient.h"
#import "Constaints.h"

@implementation UIImageView (Download)

-(UIImage*)getImageFromDocumentFolder:(NSString*)icon{
    
    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:kFolderName];
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *filePath = [stringPath stringByAppendingFormat:@"/%@.png",icon];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        return [[UIImage alloc] initWithContentsOfFile:filePath];
    }
    return nil;
}

-(void) saveImageToDocumentsWithName:(NSString*)icon image:(UIImage*)image{
    
    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:kFolderName];
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *filePath = [stringPath stringByAppendingFormat:@"/%@.png",icon];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
}

-(void)setImageFromIcon:(NSString*)icon{
    
    UIImage* image = [self getImageFromDocumentFolder:icon];
    if (image == nil){
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[AFNetworkingClient sharedInstance] downloadImage:icon completion:^(UIImage *  image, NSError * error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (image != nil) {
                        self.image = image;
                        [self saveImageToDocumentsWithName:icon image:image];
                    }
                });
            }];
        });
    }else{
        self.image = image;
    }
}
@end
