//
//  ExternalBorder.h
//  FairyTale_First
//
//  Created by Igor Kolpachkov on 06.08.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "StaticGameObject.h"

@interface ExternalBorder : StaticGameObject

@property (nonatomic, retain) NSMutableArray *shapesArray;

- (id)initWithLocation:(cpVect)location;
- (void)addToSpace:(ChipmunkSpace *)aSpace;
- (void)removeFromSpace:(ChipmunkSpace *)aSpace;

@end
