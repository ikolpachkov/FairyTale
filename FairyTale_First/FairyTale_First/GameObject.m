//
//  GameObject.m
//  EFS
//
//  Created by Smartbit Smartbit on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject
@synthesize body = _body;
@synthesize shape = _shape;
@synthesize location = _location;
@synthesize skinFileName = _skinFileName;

#ifdef LEVEL_EDITING
@synthesize joint = _joint;
#endif

- (void)dealloc
{
	[_shape release];
	[_body release];
    
	[_skinFileName release], _skinFileName = nil;
    
	[super dealloc];
}


- (id)initWithSkinFileName:(NSString *)aName
                  vertsNum:(uint)aNum
                     verts:(cpVect *)aVerts
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation
                staticBody:(BOOL)isStatic
{
	if (aName)
	{
		self = [super initWithFile:aName];
	}
	else
	{
		self = [super init];
		[self preloadAnimation];
		DebugLog(@"Init animatable object.");
	}
    
	self.skinFileName = aName;
    
	if (self)
	{
		ChipmunkBody *aBody;
        
		if (isStatic)
			aBody = [[ChipmunkBody alloc] initStaticBody];
		else
			aBody = [[ChipmunkBody alloc] initWithMass:aMass andMoment:aMoment];
        
		self.body = aBody;
		[aBody release];
        
		NSAssert(cpPolyValidate(aVerts, aNum), @"For %@ shape verts not valid.", self);
        
		ChipmunkPolyShape *aShape = [[ChipmunkPolyShape alloc] initWithBody:_body count:aNum verts:aVerts offset:cpvzero];
		self.shape = aShape;
		[aShape release];
        
		[_shape setLayers:kCollisionLayerObject];
		[_shape setCollisionType:aType];
		[_shape setElasticity:anElasticity];
		[_shape setFriction:0.5f];
        
		[self setLocation:aLocation];
        
		[_body setData:self];
	}
    
	return self;
}


- (id)initWithSkinFileName:(NSString *)aName
                    radius:(float)aRadius
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation
                staticBody:(BOOL)isStatic
{
	if (aName)
	{
		self = [super initWithFile:aName];
	}
	else
	{
		self = [super init];
		[self preloadAnimation];
		DebugLog(@"Init animatable object.");
	}
    
	self.skinFileName = aName;
    
	if (self)
	{
		ChipmunkBody *aBody;
        
		if (isStatic)
			aBody = [[ChipmunkBody alloc] initStaticBody];
		else
			aBody = [[ChipmunkBody alloc] initWithMass:aMass andMoment:aMoment];
        
		self.body = aBody;
		[aBody release];
        
		ChipmunkCircleShape *aShape = [[ChipmunkCircleShape alloc] initWithBody:_body radius:aRadius offset:cpvzero];
		self.shape = aShape;
		[aShape release];
        
		[_shape setLayers:kCollisionLayerObject];
		[_shape setCollisionType:aType];
		[_shape setElasticity:anElasticity];
		[_shape setFriction:0.5f];
        
		[self setLocation:aLocation];
        
		[_body setData:self];
	}
    
	return self;
}


- (id)initWithProperties:(NSDictionary *)aProperties
{
	return [self init];
}


- (void)setLocation:(CGPoint)aLocation
{
	self.positionInPixels = aLocation;
	self.body.pos = aLocation;
}


- (cpVect)location
{
	return self.body.pos;
}


- (NSMutableDictionary *)objectProperties
{
	NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
    
	if (_skinFileName)
		[properties setObject:_skinFileName forKey:kPropertiesSkinName];
    
	NSDictionary *positionProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:self.location.x], @"x", [NSNumber numberWithFloat:self.location.y], @"y", nil];
	[properties setObject:positionProperties forKey:kPropertiesPositionName];
    
	return [properties autorelease];
}


- (void)addToSpace:(ChipmunkSpace *)aSpace
{
	NSAssert((self.body != nil && self.shape != nil), @"Body and shape must not be nil");
    
	if (![self.body isStatic])
		[aSpace smartAdd:self.body];
    
	[aSpace smartAdd:self.shape];
    
}


- (void)removeFromSpace:(ChipmunkSpace *)aSpace
{
	if (cpSpaceContainsBody(aSpace.space, self.body.body) && !self.body.isStatic)
		[aSpace smartRemove:self.body];
    
	if (cpSpaceContainsShape(aSpace.space, self.shape.shape))
		[aSpace smartRemove:self.shape];
}


- (void)addToLayer:(CCLayer *)aLayer
{
	NSAssert(self.parent == nil, @"child already added. It can't be added again");
    
    [aLayer addChild:self z:1000];
}


- (void)removeFromLayer:(CCLayer *)aLayer
{
	if (self.parent)
		[aLayer removeChild:self cleanup:YES];
}


- (void)preloadAnimation
{
    
}


- (void)playBoomAnimation
{
    
}

@end