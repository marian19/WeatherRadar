//
//  City+CoreDataProperties.m
//  
//
//  Created by Marian on 9/8/18.
//
//

#import "City+CoreDataProperties.h"

@implementation City (CoreDataProperties)

+ (NSFetchRequest<City *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"City"];
}

@dynamic name;
@dynamic weatherHistory;

@end
