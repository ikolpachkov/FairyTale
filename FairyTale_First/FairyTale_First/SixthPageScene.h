//
//  SixthPageScene.h
//  FairyTale_First
//
//  Created by Igor Kolpachkov on 05.08.12.
//
//

#import "CCScene.h"

@class SixthPageDynamicLayer;
@class SixthPageStaticLayer;
@interface SixthPageScene : CCScene

@property (nonatomic, retain) SixthPageDynamicLayer *dynamicLayer;
@property (nonatomic, retain) SixthPageStaticLayer *staticLayer;

@end
