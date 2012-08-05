//
//  SGVertexArray.h
//
//  Created by Kashyrin Sergey on 11/21/11.
//  Copyright (c) 2011 Smartbit. All rights reserved.
//

typedef struct {
	int num, max;
	CGPoint *arr;
} SGVertexArray;


SGVertexArray *SGVertexArrayNew(int size);
SGVertexArray *SGVertexArrayCopy(SGVertexArray *arr);

void SGVertexArrayFree(SGVertexArray *arr);
void SGVertexArraySetElement(SGVertexArray *arr, CGPoint p, int index);
void SGVertexArraySetSize(SGVertexArray *arr, int size);
void SGVertexArrayReset(SGVertexArray *arr);

CGPoint SGVertexArrayGetElement(SGVertexArray *arr, int index);
