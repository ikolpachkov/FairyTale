//
//  ExternalBorder.m
//  FairyTale_First
//
//  Created by Igor Kolpachkov on 06.08.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ExternalBorder.h"
#import "SpaceHelper.h"
@interface ExternalBorder()

- (void)createStaticBodyWithLocation:(cpVect)location num:(int)num verts:(cpVect*)aVerts;

@end

@implementation ExternalBorder

@synthesize shapesArray = _shapesArray;

- (void)dealloc
{
    [_shapesArray release];
    [super dealloc];
}

- (id)initWithLocation:(cpVect)location
{
    self = [super init];
    if (self) {
        
        _shapesArray = [[NSMutableArray alloc] init];
        int num1 = 4;
        CGPoint verts1[] = {
            cpv(-301.5f, -266.4f),
            cpv(376.7f, -265.4f),
            cpv(400.5f, -285.1f),
            cpv(-319.7f, -289.0f)
        };
        [self createStaticBodyWithLocation:location num:num1 verts:verts1];
        
        int num2 = 4;
        CGPoint verts2[] = {
            cpv(-313.7f, -263.9f),
            cpv(-317.9f, -316.3f),
            cpv(-447.2f, -254.8f),
            cpv(-404.5f, -206.3f)
        };
        [self createStaticBodyWithLocation:location num:num2 verts:verts2];
        
        int num3 = 4;
        CGPoint verts3[] = {
            cpv(-407.9f, -201.6f),
            cpv(-445.8f, -237.4f),
            cpv(-506.8f, -112.9f),
            cpv(-465.3f, -106.1f)
        };
        [self createStaticBodyWithLocation:location num:num3 verts:verts3];
        
        int num4 = 4;
        CGPoint verts4[] = {
            cpv(-463.6f, -97.5f),
            cpv(-505.7f, -99.0f),
            cpv(-501.6f, 33.8f),
            cpv(-455.5f, 28.9f)
        };
        [self createStaticBodyWithLocation:location num:num4 verts:verts4];
        
        int num5 = 4;
        CGPoint verts5[] = {
            cpv(-453.8f, 33.9f),
            cpv(-505.9f, 51.5f),
            cpv(-439.4f, 181.8f),
            cpv(-387.9f, 153.4f)
        };
        [self createStaticBodyWithLocation:location num:num5 verts:verts5];
        
        int num6 = 4;
        CGPoint verts6[] = {
            cpv(-388.2f, 152.4f),
            cpv(-435.8f, 200.2f),
            cpv(-257.2f, 309.2f),
            cpv(-231.9f, 260.8f)
        };
        [self createStaticBodyWithLocation:location num:num6 verts:verts6];
        
        int num7 = 4;
        CGPoint verts7[] = {
            cpv(-227.7f, 263.8f),
            cpv(-239.8f, 319.6f),
            cpv(-37.8f, 346.4f),
            cpv(-42.8f, 303.8f)
        };
        [self createStaticBodyWithLocation:location num:num7 verts:verts7];
        
        int num8 = 4;
        CGPoint verts8[] = {
            cpv(-33.1f, 306.6f),
            cpv(-31.3f, 351.5f),
            cpv(191.2f, 314.3f),
            cpv(175.4f, 269.4f)
        };
        [self createStaticBodyWithLocation:location num:num8 verts:verts8];
        
        int num9 = 4;
        CGPoint verts9[] = {
            cpv(186.7f, 265.5f),
            cpv(204.1f, 302.9f),
            cpv(400.7f, 191.1f),
            cpv(373.2f, 152.4f)
        };
        [self createStaticBodyWithLocation:location num:num9 verts:verts9];
        
        int num10 = 4;
        CGPoint verts10[] = {
            cpv(375.3f, 153.6f),
            cpv(408.1f, 177.4f),
            cpv(497.0f, 23.1f),
            cpv(456.4f, 4.5f)
        };
        [self createStaticBodyWithLocation:location num:num10 verts:verts10];
        
        int num11 = 4;
        CGPoint verts11[] = {
            cpv(463.4f, -3.9f),
            cpv(501.3f, 6.8f),
            cpv(502.8f, -141.9f),
            cpv(468.1f, -136.6f)
        };
        [self createStaticBodyWithLocation:location num:num11 verts:verts11];
        
        int num12 = 4;
        CGPoint verts12[] = {
            cpv(468.2f, -139.0f),
            cpv(503.9f, -149.4f),
            cpv(461.8f, -261.5f),
            cpv(383.6f, -261.3f)
        };
        [self createStaticBodyWithLocation:location num:num12 verts:verts12];
        
        [[[SpaceHelper sharedSpaceHelper] currentSpace] addCollisionHandler:self typeA:(id)kCollisionDynamicGameObject typeB:(id)kCollisionGround begin:@selector(begin:space:) preSolve:nil postSolve:nil separate:nil];
    }
    return self;
}

- (void)createStaticBodyWithLocation:(cpVect)location num:(int)num verts:(cpVect*)aVerts
{
    ChipmunkBody *body = [ChipmunkBody staticBody];
    ChipmunkPolyShape *shape = [ChipmunkPolyShape polyWithBody:body count:num verts:aVerts offset:cpvzero];
    [shape setCollisionType:kCollisionGround];
    [body setPos:location];
    [shape setFriction:GROUND_FRICTION];
    [shape setElasticity:GROUND_ELASTICITY];
    [shape setLayers:CP_ALL_LAYERS];

    [_shapesArray addObject:shape];
}

- (void)addToSpace:(ChipmunkSpace *)aSpace
{
    for (ChipmunkPolyShape *shape in  _shapesArray) {
        [aSpace smartAdd:shape];
    }
}

- (void)removeFromSpace:(ChipmunkSpace *)aSpace
{
    for (ChipmunkPolyShape *shape in  _shapesArray) {
        [aSpace smartRemove:shape];
    }
}


- (bool)begin:(cpArbiter *)arbiter space:(ChipmunkSpace*)space
{
    return YES;
}


@end
