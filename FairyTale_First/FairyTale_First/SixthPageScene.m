//
//  SixthPageScene.m
//  FairyTale_First
//
//  Created by Igor Kolpachkov on 05.08.12.
//
//

#import "SixthPageScene.h"
#import "SixthPageDynamicLayer.h"
#import "SixthPageStaticLayer.h"

@implementation SixthPageScene

@synthesize dynamicLayer = _dynamicLayer;
@synthesize staticLayer = _staticLayer;;


- (void)dealloc
{
    [super dealloc];
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	SixthPageScene *layer = [SixthPageScene node];
	[scene addChild: layer];
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        _dynamicLayer = [SixthPageDynamicLayer node];
        [self addChild:_dynamicLayer];
        
        _staticLayer = [SixthPageStaticLayer node];
        [self addChild:_staticLayer];
    }
    return self;
}


@end

