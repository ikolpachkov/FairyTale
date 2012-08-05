//
//  ShapeGenerator.h
//
//  Created by Artyom Peshkov on 25.04.12.
//  Copyright (c) 2012 Smartbit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGVertexArray.h"
#import "SGVertexScanner.h"

@interface ShapeGenerator : NSObject

+ (SGVertexArray*)scanImage:(UIImage*)image;

@end
