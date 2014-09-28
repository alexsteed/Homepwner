//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Alexis Bastide on 21/08/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

#pragma mark - Items archiving

- (NSString *)itemArchivePath
{
    // Make sure that the first argument is NSDocumentDirectory and not NSDocumentationDirectory
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get the one document directory from that list
    NSString *documentDirectory= [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    
    // Returns YES on success
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

#pragma mark - Initialization

    // If a program calls [[BNRItem alloc] init] tell him the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [[BNRItemStore]" userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one
        if (!_privateItems)
        {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

#pragma mark - Items management

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedStore = [[self alloc] initPrivate];});
    return sharedStore;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [[BNRItem alloc] init];
    
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex)
        return;
    
    // Get a pointer to object being removed so you can reinsert it
    BNRItem *item = self.privateItems[fromIndex];
    
    // Remove the item from the array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Insert the item in array in location
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end