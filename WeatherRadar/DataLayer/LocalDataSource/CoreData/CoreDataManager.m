
#import "CoreDataManager.h"

@interface CoreDataManager ()

- (void)initializeCoreData;

@property (nonatomic, strong) NSURL *storeURL;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager

+(instancetype)sharedInstance {
    
    static CoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    
    self = [super init];
    if (!self) return nil;
    
    [self initializeCoreData];
    
    return self;
}

#pragma mark - Core Data stack

- (void)initializeCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WeatherRadar" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSAssert(_managedObjectModel != nil, @"Error initializing Managed Object Model");
    
    self.storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WeatherRadar.sqlite"];
    
    
    self.managedObjectContext = [self setupManagedObjectContextWithConcurrencyType:NSMainQueueConcurrencyType];
    self.backgroundManagedObjectContext = [self setupManagedObjectContextWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification object:nil  queue:nil  usingBlock:^(NSNotification* note) {
        NSManagedObjectContext *moc = self.managedObjectContext;
        if (note.object != moc) {
            [moc performBlock:^(){
                [moc mergeChangesFromContextDidSaveNotification:note];
            }];
        }
    }];
}

- (NSManagedObjectContext *)setupManagedObjectContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType
{
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];
    
    managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSError* error;
    NSPersistentStore *store = [managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                                             configuration:nil
                                                                                                       URL:self.storeURL
                                                                                                   options:@{NSMigratePersistentStoresAutomaticallyOption:@YES,NSInferMappingModelAutomaticallyOption:@YES}
                                                                                                     error:&error];
    
    if (!store) {
        NSLog(@"Failed to create PersistentStore");
    }
    
    NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    
    return managedObjectContext;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    [self saveMainContext];
    [self saveBackgroundContext];
}

- (void)saveMainContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

- (void)saveBackgroundContext {
    NSManagedObjectContext *managedObjectContext = self.backgroundManagedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

- (void)deleteAllCoreDataObjects {
    
    if (_managedObjectContext != nil) {
        NSDictionary *allEntities = _managedObjectModel.entitiesByName;
        
        for (NSString* entityName in [allEntities allKeys]) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext];
            [fetchRequest setEntity:entity];
            NSError *error;
            NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
            for (NSManagedObject *managedObject in items) {
                [_managedObjectContext deleteObject:managedObject];
            }
            if (![_managedObjectContext save:&error]) {
            }
        }
    }
}

@end
