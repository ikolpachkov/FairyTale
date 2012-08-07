//
//  SpaceHelper.h
//  EFS
//
//  Created by Smartbit Smartbit on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ObjectiveChipmunk.h"

#import "ChipmunkDebugNode.h"
#import "DynamicGameObject.h"

@interface SpaceHelper : CCNode <UIAccelerometerDelegate>

@property (nonatomic, retain) ChipmunkSpace *currentSpace;
@property (nonatomic, assign) BOOL pause;
@property (nonatomic, retain) ChipmunkDebugNode *debug;
@property (nonatomic, assign) float updateSpaceInterval;
@property (nonatomic, assign) BOOL isUsingAccelerometer;

+ (id) sharedSpaceHelper;

- (void)startSimulation;
- (void)stopSimulation;
- (void)pauseSimulation;
- (void)resumeSimulation;
- (void)cleanSpace;

- (void)update:(ccTime)dt;
@end
