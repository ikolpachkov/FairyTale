//
//  ApplicationHelper.m
//  FairyTale_First
//
//  Created by Igor Kolpachkov on 05.08.12.
//
//

#import "ApplicationHelper.h"

@implementation ApplicationHelper

#pragma mark - Singleton Methods

static ApplicationHelper *sharedInstance = nil;

+ (ApplicationHelper *)sharedApplicationHelper
{
    @synchronized(self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[self alloc] init];
        });
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (oneway void)release
{
    // do nothing
}

- (id)autorelease
{
    return self;
}

#pragma mark Instance Setup

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


@end
