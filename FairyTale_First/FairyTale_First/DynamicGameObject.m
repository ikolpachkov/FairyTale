//
//  DynamicGameObject.m
//  EFS
//
//  Created by Smartbit Smartbit on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DynamicGameObject.h"

@implementation DynamicGameObject

-(void)dealloc
{
    [super dealloc];
}

- (id)initWithSkinFileName:(NSString*)aName 
                  vertsNum:(uint)aNum
                     verts:(cpVect*)aVerts
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation
{
    return [super initWithSkinFileName:aName vertsNum:aNum verts:aVerts mass:aMass moment:aMoment elasticity:anElasticity collisionType:aType location:aLocation staticBody:NO];
}

- (id)initWithSkinFileName:(NSString*)aName 
                    radius:(float)aRadius
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation
{
    return [super initWithSkinFileName:aName radius:aRadius mass:aMass moment:aMoment elasticity:anElasticity collisionType:aType location:aLocation staticBody:NO];
}

- (void)updatePosition
{
    self.positionInPixels = self.body.pos;
    self.rotation = CC_RADIANS_TO_DEGREES(-1*self.body.angle);
}

@end
