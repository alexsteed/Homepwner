//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Alexis Bastide on 04/09/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

#pragma mark - Storage management

+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore = nil;

    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    return  sharedStore;
}

// No one should call init
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

// Secret designated initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %d images out of the cache", [self.dictionary count]);
    [self.dictionary removeAllObjects];
}

#pragma mark - Images management

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
    
    // Create full path for image
    NSString *imagePath = [self imageForPathKey:key];
    
    // Turn image into JPEG data
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    // Write its full path
    [data writeToFile:imagePath atomically:YES];
}

- (NSString *)imageForPathKey:(NSString *)key;
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

- (UIImage *)imageForKey:(NSString *)key
{
    // If possible, get it form the dictionnary
    UIImage *result = self.dictionary[key];
    
    if (!result)
    {
        NSString *imagePath = [self imageForPathKey:key];
        
        // Create UIImage from file
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        // If we found an image on the file system, place it into cache
        if (result)
        {
            self.dictionary[key] = result;
        }
        else
        {
            NSLog(@"Error : unable to find %@", [self imageForPathKey:key]);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key)
    {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    NSString *imagePath = [self imageForPathKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

@end
