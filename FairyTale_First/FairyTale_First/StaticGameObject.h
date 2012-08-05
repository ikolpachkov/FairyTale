//
//  StaticGameObject.h
//  EFS
//
//  Created by Smartbit Smartbit on 02.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"

@interface StaticGameObject : GameObject 

@property (nonatomic, assign) CGSize size;


- (id)initWithSkinFileName:(NSString*)aName 
                  vertsNum:(uint)aNum
                     verts:(cpVect*)aVerts
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation;

- (id)initWithSkinFileName:(NSString*)aName 
                    radius:(float)aRadius
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation;


@end
