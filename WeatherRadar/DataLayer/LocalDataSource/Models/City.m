//
//  City+CoreDataClass.m
//  
//
//  Created by Marian on 9/8/18.
//
//

#import "City.h"
#import "CoreDataManager.h"

@implementation City

+(NSString*)entityName {
    return @"City";
}

+ (BOOL)addCity:(NSString *)cityName{
    
    NSManagedObjectContext *managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext;
    City* fetchedCity = [City getCityWithName:cityName];
    if (fetchedCity == nil){
        fetchedCity = [NSEntityDescription
                       insertNewObjectForEntityForName:[City entityName]
                       inManagedObjectContext:managedObjectContext];
        fetchedCity.name = cityName;
        NSError *error = nil;
        
        [managedObjectContext save:&error];
        return YES;
    }else{
        return NO;
    }
}


+(City*) getCityWithName:(NSString *)cityName{
    
    City* fetchedCity = nil;
    NSManagedObjectContext *managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name LIKE[cd] %@", cityName];
    NSFetchRequest *fetchRequest = [City fetchRequest];
    NSError *error = nil;
    [fetchRequest setPredicate:predicate];
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (results.firstObject != nil) {
        fetchedCity = results.firstObject;
    }
    return fetchedCity;
    
}

+(void)deleteCity:(City *)city{
    NSManagedObjectContext *managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext;
    
    [managedObjectContext deleteObject:city];
    NSError *error = nil;
    
    [managedObjectContext save:&error];
}

+(NSArray<City *>*) getAllUserCities{
    
    NSManagedObjectContext *managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext;
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:[City fetchRequest] error:&error];

    return results;
    
    
}
@end
