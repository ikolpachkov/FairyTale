//
//  HelloWorldLayer.m
//  FairyTale_First
//
//  Created by Igor Kolpachkov on 05.08.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "SplashScreenScene.h"

#warning !!!!!
#import "SixthPageScene.h"

@implementation SplashScreenScene

+(CCScene *) scene
{

	CCScene *scene = [CCScene node];
	SplashScreenScene *layer = [SplashScreenScene node];
	[scene addChild: layer];
	return scene;
}


-(id) init
{
	if( (self=[super init])) {
		
        self.isTouchEnabled = YES;
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Splash screen" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position =  ccp( size.width /2 , size.height/2 );
		[self addChild: label];
	}
	return self;
}


- (void) dealloc
{

	[super dealloc];
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[SixthPageScene scene]]];

}

@end
