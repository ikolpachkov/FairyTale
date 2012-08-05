//
//  VertexCache.m
//  EFS
//
//  Created by Artyom Peshkov on 17.01.12.
//  Copyright 2012 Smartbit. All rights reserved.
//

#import "VertexCache.h"

@interface VertexCache ()

- (NSValue *)cpVectArrayToNSValue:(SGVertexArray *)array;
- (SGVertexArray *)NSValueTocpVectArray:(NSValue *)value;

@end

@implementation VertexCache

#pragma mark - Singleton Methods

static VertexCache * sharedInstance = nil;

+ (VertexCache *)sharedVertexCache
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
		if (sharedInstance == nil)
		{
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

- (id)init
{
	self = [super init];
    
	if (self)
		cache = [[NSMutableDictionary alloc] init];
    
	return self;
}


#pragma mark Custom Methods

- (SGVertexArray *)NSValueTocpVectArray:(NSValue *)value
{
	return [value pointerValue];
}


- (NSValue *)cpVectArrayToNSValue:(SGVertexArray *)array
{
	return [NSValue valueWithPointer:array];
}


- (void)addVertex:(SGVertexArray *)vertex key:(NSString *)key
{
	[cache setObject:[self cpVectArrayToNSValue:vertex] forKey:key];
}


- (SGVertexArray *)vertexForKey:(NSString *)key
{
	SGVertexArray *array = [self NSValueTocpVectArray:[cache objectForKey:key]];
	return array;
}


- (void)clearCache
{
	for (NSValue *value in cache)
	{
		SGVertexArray *array = [self NSValueTocpVectArray:value];
		SGVertexArrayFree(array);
	}
    
	[cache removeAllObjects];
}


- (uint)vertexCount
{
	return [cache count];
}


- (NSArray *)allKeys
{
	return [cache allKeys];
}


- (NSArray *)allValues
{
	return [cache allValues];
}


@end