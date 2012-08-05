//
//  StaticGameObject.m
//  EFS
//
//  Created by Smartbit Smartbit on 02.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaticGameObject.h"

@implementation StaticGameObject

@synthesize size = _size;

-(void)dealloc{
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
    return [super initWithSkinFileName:aName vertsNum:aNum verts:aVerts mass:INFINITY moment:INFINITY elasticity:STATIC_OBJECTS_ELASTICITY collisionType:aType location:aLocation staticBody:YES];
}

- (id)initWithSkinFileName:(NSString*)aName 
                    radius:(float)aRadius
                      mass:(float)aMass
                    moment:(float)aMoment
                elasticity:(float)anElasticity
             collisionType:(id)aType
                  location:(cpVect)aLocation
{
    return [super initWithSkinFileName:aName radius:aRadius mass:INFINITY moment:INFINITY elasticity:STATIC_OBJECTS_ELASTICITY collisionType:aType location:aLocation staticBody:YES];
}

#ifdef LEVEL_EDITING
#pragma mark - Options
- (void)showOptions
{
    UIActionSheet *shit = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:(id)self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles: nil];
    [shit showInView:[[CCDirector sharedDirector] openGLView]];
    [shit release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self removeFromSpace:[[SpaceHelper sharedSpaceHelper] currentSpace]];
            [self removeFromLayer:[[GameHelper sharedGameHelper] interactionLayer]];
        }
            break;
        default:
            break;
    }
}
#endif

@end
