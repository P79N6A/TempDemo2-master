//
//  MyView.m
//  FirstQuartz2D
//
//  Created by tony on 11-5-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyView4.h"


@implementation MyView4

- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextMoveToPoint (context, 75, 10); 
	CGContextAddLineToPoint (context, 10, 150); 
	CGContextAddLineToPoint (context, 160, 150); 
	
	// Closing the path connects the current point to the start of the current path.
	CGContextClosePath(context);
	// And stroke the path
	[[UIColor blackColor] setStroke]; 
	//CGContextStrokePath(context);
	[[UIColor redColor] setFill]; 
	CGContextDrawPath(context, kCGPathFillStroke);
	//kCGPathFillStroke,kCGPathFill,kCGPathStroke
	

}

@end
