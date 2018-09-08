
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+(instancetype)sharedInstance;

@property (strong) NSManagedObjectContext *managedObjectContext;

@property (strong) NSManagedObjectContext *backgroundManagedObjectContext;

- (void)saveContext;

- (void) deleteAllCoreDataObjects;


@end
