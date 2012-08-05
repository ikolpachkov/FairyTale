//
//  ShapeGenerator.m
//
//  Created by Artyom Peshkov on 25.04.12.
//  Copyright (c) 2012 Smartbit. All rights reserved.
//

#import "ShapeGenerator.h"

@implementation ShapeGenerator

+ (SGVertexArray*)scanImage:(UIImage*)image
{
    NSAssert(image, @"Image for scan can't be nil.");
    
    CGImageRef img = image.CGImage;
    
	size_t width = CGImageGetWidth(img);
	size_t height = CGImageGetHeight(img);
	size_t pitch = width*4;
	
	UInt8 *bits = (UInt8*)malloc(width * height * 4);
	memset(bits, 0, width*height*4);
	CGContextRef bitmapContext = CGBitmapContextCreate(bits, width, height, 8, pitch, CGImageGetColorSpace(img), kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(bitmapContext, 0, height);
	CGContextScaleCTM(bitmapContext, 1.0, -1.0);
	CGContextDrawImage(bitmapContext, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), img);
	CGContextRelease(bitmapContext);
	
	const UInt8 *data = bits;
	int cellWidth = width;
	int cellHeight = height;
	
    ImageDesc cell;
    cell.width = cellWidth;
    cell.height = cellHeight;
    cell.pitch = pitch;
    cell.data = data;
    Vec2Array points;
    findPoints(&cell, &points);
    
    SGVertexArray *pointsArray = SGVertexArrayNew(points.count);
    
    if(points.count > 0)
    {
        for(int i = 0; i < points.count; i++)
        {
            Vec2 p = points.points[i];
            p.x -= cellWidth*0.5f;
            p.y -= cellHeight*0.5f;
            SGVertexArraySetElement(pointsArray, CGPointMake(p.x, p.y), i);
        }
    }
    
    if(points.points)
    {
        free(points.points);
    }
    
	free(bits);
    
    return pointsArray;
}

@end
