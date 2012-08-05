//
//  SGVeretxArray.m
//
//  Created by Kashyrin Sergey on 11/21/11.
//  Copyright (c) 2011 Smartbit. All rights reserved.
//

#import "SGVertexArray.h"
#include <assert.h>

SGVertexArray *SGVertexArrayNew(int size)
{
    SGVertexArray *arr = (SGVertexArray *)calloc(1, sizeof(SGVertexArray));
    
    arr->num = 0;
    arr->max = (size ? size : 1);
    arr->arr = (CGPoint *)calloc(arr->max, sizeof(CGPoint));
    
    return arr;
}

SGVertexArray *SGVertexArrayCopy(SGVertexArray *arr)
{
    SGVertexArray *new = SGVertexArrayNew(arr->max);
    
    for (int i=0; i<arr->num; i++) 
    {
        SGVertexArraySetElement(new, SGVertexArrayGetElement(arr, i), i);
    }
    
    return new;
}

void SGVertexArrayFree(SGVertexArray *arr)
{
    if (arr) 
    {
        free(arr->arr), arr->arr = NULL;
        free(arr), arr = NULL;
    }
}


void SGVertexArraySetElement(SGVertexArray *arr, CGPoint p, int index)
{
    assert(index < arr->max);
    
    if (index >= arr->num) 
    {
        arr->num = index+1;
        if (arr->num >= arr->max) 
        {
            arr->max ++;
            arr->arr = (CGPoint *)realloc(arr->arr, arr->max * sizeof(CGPoint));
        }
    }
    
    arr->arr[index] = p;
}

CGPoint SGVertexArrayGetElement(SGVertexArray *arr, int index)
{
    assert(index < arr->num);
    return arr->arr[index];
}

void SGVertexArraySetSize(SGVertexArray *arr, int size)
{  
    if (size>arr->max) 
    {
        arr->max=size;
        arr->arr = (CGPoint *)realloc(arr->arr, arr->max * sizeof(CGPoint));
    }
    else
    {
        arr->num=size;
        
        if (arr->num ==arr->max) 
        {
            arr->max *=2;
            arr->arr = (CGPoint *)realloc(arr->arr, arr->max * sizeof(CGPoint));
        }
    }
}

void SGVertexArrayReset(SGVertexArray *arr)
{
    arr->num=0;
}




