//
//  MyView.m
//  FirstQuartz2D
//
//  Created by tony on 11-5-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyView2.h"


@implementation MyView2

- (void)drawRect:(CGRect)rect {
	
	CGContextRef cgContext = UIGraphicsGetCurrentContext();
	
	//CGContextBeginPath(cgContext);
    CGContextMoveToPoint(cgContext, 333, 0);
    CGContextAddCurveToPoint(cgContext, 333, 0, 332, 26, 330, 26);
    CGContextAddCurveToPoint(cgContext, 330, 26, 299, 20, 299, 17);
    CGContextAddLineToPoint(cgContext, 296, 17);
    CGContextAddCurveToPoint(cgContext, 296, 17, 296, 19, 291, 19);
    CGContextAddLineToPoint(cgContext, 250, 19);
    CGContextAddCurveToPoint(cgContext, 250, 19, 241, 24, 238, 19);
    CGContextAddCurveToPoint(cgContext, 236, 20, 234, 24, 227, 24);
    CGContextAddCurveToPoint(cgContext, 220, 24, 217, 19, 216, 19);
    CGContextAddCurveToPoint(cgContext, 214, 20, 211, 22, 207, 20);
    CGContextAddCurveToPoint(cgContext, 207, 20, 187, 20, 182, 21);
    CGContextAddLineToPoint(cgContext, 100, 45);
    CGContextAddLineToPoint(cgContext, 97, 46);
    CGContextAddCurveToPoint(cgContext, 97, 46, 86, 71, 64, 72);
    CGContextAddCurveToPoint(cgContext, 42, 74, 26, 56, 23, 48);
    CGContextAddLineToPoint(cgContext, 9, 47);
    CGContextAddCurveToPoint(cgContext, 9, 47, 0, 31, 0, 0);
	
    CGContextStrokePath(cgContext);
}

@end
