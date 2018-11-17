//
//  MyView.m
//  FirstQuartz2D
//
//  Created by tony on 11-5-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"


@implementation MyView

- (void)drawRect:(CGRect)rect {

	NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"jpg"];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
    
    
	UIImage *img = [UIImage imageWithContentsOfFile:path];
	CGImageRef image = img.CGImage;
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
    
	CGAffineTransform myAffine = CGAffineTransformMakeRotation(M_PI); 
	myAffine = CGAffineTransformTranslate(myAffine, -img.size.width, -img.size.height);
	CGContextConcatCTM(context, myAffine);
    
	CGRect touchRect = CGRectMake(0, 0, img.size.width, img.size.height);
	CGContextDrawImage(context, touchRect, image);  
	CGContextRestoreGState(context);


}


@end
