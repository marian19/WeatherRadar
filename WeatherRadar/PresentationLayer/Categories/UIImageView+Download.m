//
//  UIImageView+Download.m
//  WeatherRadar
//
//  Created by Marian on 9/10/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "UIImageView+Download.h"
#import "AFNetworkingClient.h"

@implementation UIImageView (Download)

-(void) setImageFromIcon:(NSString*)icon{
    
    [[AFNetworkingClient sharedInstance] downloadImage:icon completion:^(UIImage *  image, NSError * error) {
        
        if (image != nil) {
            self.image = image;
        }
    }];
}
@end
