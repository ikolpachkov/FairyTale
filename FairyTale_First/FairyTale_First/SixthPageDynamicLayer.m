//
//  DynamicLayer.m
//  FairyTale_First
//
//  Created by Igor Kolpachkov on 05.08.12.
//
//

#import "SixthPageDynamicLayer.h"
#import "SpaceHelper.h"

#import "DynamicGameObject.h"
#import "StaticGameObject.h"
#import "VertexCache.h"
#import "ShapeGenerator.h"

#import "ExternalBorder.h"

#define DYNAMIC_BODY_MASS 1
#define STATIC_BODY_MASS 1

@implementation SixthPageDynamicLayer

- (void)dealloc
{
    
    [super dealloc];
}


- (id)init
{
    self = [super initWithColor:ccc4(100, 100, 100, 255)];
    if (self) {
        
        SpaceHelper *spaceHelper = [SpaceHelper sharedSpaceHelper];
        ChipmunkDebugNode *node = [[ChipmunkDebugNode alloc] init];
		[node setSpace:[spaceHelper currentSpace]];
		[self addChild:node];
		[node release];
        
        
        [spaceHelper startSimulation];

//******** add Dynamic object
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGPoint position = ccp(winSize.width/2, winSize.height/2);
        
        int num = 4;
        CGPoint verts[] = {
            cpv(-20.0f, -20.0f),
            cpv(-20.0f, 20.0f),
            cpv(20.0f, 20.0f),
            cpv(20.0f, -20.0f)
        };
        float moment = cpMomentForPoly(DYNAMIC_BODY_MASS, num, verts, cpvzero);
        
        DynamicGameObject *testDynamicObject = [[DynamicGameObject alloc] initWithSkinFileName:@"72.png" vertsNum:num verts:verts mass:DYNAMIC_BODY_MASS moment:moment elasticity:0.1 collisionType:kCollisionDynamicGameObject location:position];
        
        [testDynamicObject addToSpace:[spaceHelper currentSpace]];
        [testDynamicObject addToLayer:self];
//******** add Dynamic object
        
//******** add Static object        
        
        
        StaticGameObject *testStaticGameObject = [[StaticGameObject alloc] initWithSkinFileName:@"72.png" vertsNum:num verts:verts mass:INFINITY moment:INFINITY elasticity:0.1 collisionType:kCollisionStaticGameObject location:ccp(winSize.width/3, winSize.height/2)];
     
        [testStaticGameObject addToSpace:[spaceHelper currentSpace]];
        [testStaticGameObject addToLayer:self];
//******** add Static object
        
        
//******** dynamic with automatic vertex
        
        NSString  *skin = @"72.png";
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"72" ofType:@"png"]];
        SGVertexArray *array = [[VertexCache sharedVertexCache] vertexForKey:skin];
        
        if (array != nil) {
            DebugLog(@"Take vertex for image:%@ from cache.", skin);
            array = [[VertexCache sharedVertexCache] vertexForKey:skin];
        }
        else
        {
            DebugLog(@"Scan image:%@ for vertexes and add it to cache.", skin);
            array = [ShapeGenerator scanImage:image];
            [[VertexCache sharedVertexCache] addVertex:array key:skin];
        }
        
        NSAssert(cpPolyValidate(array->arr, array->num), @"Cant validate poly shape for %@", skin);
        
        int vertsCount = array->num;
        float momentVH = cpMomentForPoly(DYNAMIC_BODY_MASS, array->num, array->arr, cpvzero);
        
        DynamicGameObject *testDynamicObjectVH = [[DynamicGameObject alloc] initWithSkinFileName:@"72.png" vertsNum:vertsCount verts:array->arr mass:DYNAMIC_BODY_MASS moment:momentVH elasticity:0.1 collisionType:kCollisionDynamicGameObject location:ccp(winSize.width/3*2, winSize.height/2)];
        
        [testDynamicObjectVH addToSpace:[spaceHelper currentSpace]];
        [testDynamicObjectVH addToLayer:self];
        
//******** dynamic with automatic vertex
        
        
        ExternalBorder *externalBorderObject = [[ExternalBorder alloc] initWithLocation:position];
        [externalBorderObject addToSpace:[spaceHelper currentSpace]];
        
    }
    return self;
}

@end
