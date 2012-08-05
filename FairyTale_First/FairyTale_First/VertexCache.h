//
//  VertexCache.h
//  EFS
//
//  Created by Artyom Peshkov on 17.01.12.
//  Copyright 2012 Smartbit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SGVertexArray.h"

@interface VertexCache : NSObject
{
    NSMutableDictionary *cache;
}

+ (VertexCache *)sharedVertexCache;

- (void)addVertex:(SGVertexArray*)vertex key:(NSString*)key;
- (SGVertexArray*)vertexForKey:(NSString*)key;

- (void)clearCache;
- (uint)vertexCount;

- (NSArray*)allKeys;
- (NSArray*)allValues;

@end
