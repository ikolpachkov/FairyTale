//
//  GameObject.h
//  EFS
//
//  Created by Smartbit Smartbit on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ObjectiveChipmunk.h"

#import "CollisionTypes.h"
#import "CommonProtocol.h"

#define kPropertiesSkinName @"Skin"
#define kPropertiesPositionName @"Position"

@protocol GameObject <NSObject>
@required
- (void)addToSpace:(ChipmunkSpace*)aSpace;
- (void)removeFromSpace:(ChipmunkSpace*)aSpace;

- (void)addToLayer:(CCLayer*)aLayer;
- (void)removeFromLayer:(CCLayer*)aLayer;

- (ChipmunkBody*)body;
- (ChipmunkShape*)shape;

- (void)setLocation:(CGPoint)aLocation;
- (CGPoint)location;


@optional
- (void)preloadAnimation;

@end

@protocol GameItemsCarrying <NSObject>
@required
- (id)initWithProperties:(NSDictionary*)aProperties;
@end

@interface GameObject : CCSprite <GameObject>

@property (nonatomic, retain) ChipmunkBody *body;
@property (nonatomic, retain) ChipmunkShape *shape;
@property (nonatomic, assign) cpVect location;
@property (nonatomic, copy) NSString *skinFileName;


- (id)initWithSkinFileName:(NSString*)aName 
                  vertsNum:(uint)aNum
                     verts:(cpVect*)aVerts
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation
                staticBody:(BOOL)isStatic;

- (id)initWithSkinFileName:(NSString*)aName 
                    radius:(float)aRadius
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation
                staticBody:(BOOL)isStatic;


@end
