//
//  DynamicGameObject.h
//  EFS
//
//  Created by Smartbit Smartbit on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>

@protocol DynamicGameObject <GameObject>
@required
- (void)updatePosition;
@end

@interface DynamicGameObject : GameObject <DynamicGameObject>

- (id)initWithSkinFileName:(NSString *)aName
                  vertsNum:(uint)aNum
                     verts:(cpVect *)aVerts
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation;

- (id)initWithSkinFileName:(NSString *)aName
                    radius:(float)aRadius
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation;

@end