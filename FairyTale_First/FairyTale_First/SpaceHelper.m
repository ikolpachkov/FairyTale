//
//  SpaceHelper.m
//  EFS
//
//  Created by Smartbit Smartbit on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpaceHelper.h"

@implementation SpaceHelper
@synthesize currentSpace = _currentSpace;
@synthesize pause = _pause;
@synthesize debug = _debug;
@synthesize updateSpaceInterval = _updateSpaceInterval;
@synthesize isUsingAccelerometer = _isUsingAccelerometer;
static SpaceHelper *_sharedSpaceHelper = nil;

+ (id)sharedSpaceHelper
{
	@synchronized (self) {
		if (_sharedSpaceHelper == nil)
			[[self alloc] init];
	}
    
	return _sharedSpaceHelper;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if (_isUsingAccelerometer) {
        switch ([[UIApplication sharedApplication] statusBarOrientation]) {
            case UIInterfaceOrientationLandscapeLeft:
                _currentSpace.gravity = cpv(-acceleration.y * SPACE_GRAVITY * adaptationCoefficient,  SPACE_GRAVITY * adaptationCoefficient);
                break;
            case UIInterfaceOrientationLandscapeRight:
                _currentSpace.gravity = cpv(acceleration.y * SPACE_GRAVITY * adaptationCoefficient,  SPACE_GRAVITY * adaptationCoefficient);
                break;
                
            default:
                break;
        }
    }
}


- (id)init
{
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1/60];
    _isUsingAccelerometer = YES;
    
	if (_sharedSpaceHelper != nil)
	{
		[NSException raise:NSInternalInconsistencyException format:@"[%@ %@] cannot be called; use +[%@ %@] instead",
		 NSStringFromClass([self class]),
		 NSStringFromSelector(_cmd),
		 NSStringFromClass([self class]),
		 NSStringFromSelector(@selector(sharedSpaceHelper))];
	}
	else if (self = [super init])
	{
		_sharedSpaceHelper = self;
		_pause = NO;
		_currentSpace = [[ChipmunkSpace alloc] init];
		_currentSpace.gravity = cpv(0, SPACE_GRAVITY * adaptationCoefficient);
        
		_currentSpace.damping = SPACE_DAMPING;
		_currentSpace.iterations = 5;

		_updateSpaceInterval = UPDATE_INTERVAL;
		//_currentSpace.sleepTimeThreshold = .5f;
        
#if COCOS2D_DEBUG
		_debug = [[ChipmunkDebugNode alloc] init];
		[_debug setSpace:_currentSpace];
#endif
	}
    
	return self;
}


- (void)update:(ccTime)dt
{
	if (!_pause)
	{
        [_currentSpace step:_updateSpaceInterval];
		for (ChipmunkBody *body in [_currentSpace bodies])
		{
			if (![body isStatic] && ![body isSleeping])
            {
                id anyObject = body.data;
                
                if (anyObject && [anyObject isKindOfClass:[DynamicGameObject class]]) 
                {
                    [anyObject updatePosition];
                }
                else 
                {
                    [(CCNode*)anyObject setPositionInPixels:body.pos];
                    [(CCNode*)anyObject setRotation:CC_RADIANS_TO_DEGREES(-1*body.angle)];
                }
            }
		}
	}
    
#ifdef LEVEL_EDITING
	cpSpaceReindexStatic(_currentSpace.space);
#endif
}


- (void)startSimulation
{
	isRunning_ = YES;
	[self scheduleUpdateWithPriority:1];
}


- (void)stopSimulation
{
	[self unscheduleAllSelectors];
}


- (void)pauseSimulation
{
	_pause = YES;
}


- (void)resumeSimulation
{
	_pause = NO;
}


- (void)cleanSpace
{
	[self pauseSimulation];
    
	NSArray *shapes = [_currentSpace shapes];
	NSArray *bodies = [_currentSpace bodies];
	NSArray *constrains = [_currentSpace constraints];
    
	for (ChipmunkShape *shape in shapes)
	{
		if (cpSpaceContainsShape(_currentSpace.space, shape.shape))
			[_currentSpace smartRemove:shape];
	}
    
	for (ChipmunkBody *body in bodies)
	{
		if (cpSpaceContainsBody(_currentSpace.space, body.body))
			[_currentSpace smartRemove:body];
	}
    
	for (ChipmunkConstraint *constraint in constrains)
	{
		if (cpSpaceContainsConstraint(_currentSpace.space, constraint.constraint))
			[_currentSpace smartRemove:constraint];
	}
    
	[self resumeSimulation];
}


- (void)dealloc
{
	_sharedSpaceHelper = nil;
	[super dealloc];
}


@end