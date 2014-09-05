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

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    // Do I need to create a sharedStore ?
    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

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
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (BNRItem *) createItem
{
    BNRItem *item = [BNRItem randomItem];
    
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