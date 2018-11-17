//
//  PinchZoomView.m
//  PinchZoom
//
//  Created by Bill Dudney on 7/3/08.
//  Copyright 2008 Gala Factory. All rights reserved.
//
//
//  Licensed with the Apache 2.0 License
//  http://apache.org/licenses/LICENSE-2.0
//

#import "PinchZoomView.h"

@implementation PinchZoomView

@synthesize robotLayer;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.robotLayer = [CALayer layer];
        UIImage *image = [UIImage imageNamed:@"Robot.png"];
        self.robotLayer.contents = (id)[image CGImage];
        self.robotLayer.bounds = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        self.robotLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        [self.layer addSublayer:self.robotLayer];
        pinchZoom = NO;
        previousDistance = 0.0f;
        zoomFactor = 1.0f;
    }
    return self;
}



//START:code.PinchZoomView.touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if(event.allTouches.count == 2) {
		pinchZoom = YES;
		NSArray *touches = [event.allTouches allObjects];
		CGPoint pointOne = [[touches objectAtIndex:0] locationInView:self];
		CGPoint pointTwo = [[touches objectAtIndex:1] locationInView:self];
		previousDistance = sqrt(pow(pointOne.x - pointTwo.x, 2.0f) + 
								pow(pointOne.y - pointTwo.y, 2.0f));
	} else {
		pinchZoom = NO;
	}
}
//END:code.PinchZoomView.touchesBegan

//START:code.PinchZoomView.touchesMoved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 两个手指的
    
	if(YES == pinchZoom && event.allTouches.count == 2) {
		NSArray *touches = [event.allTouches allObjects];
		CGPoint pointOne = [[touches objectAtIndex:0] locationInView:self];
		CGPoint pointTwo = [[touches objectAtIndex:1] locationInView:self];
		CGFloat distance = sqrt(pow(pointOne.x - pointTwo.x, 2.0f) + 
								pow(pointOne.y - pointTwo.y, 2.0f));
		zoomFactor += (distance - previousDistance) / previousDistance;
		zoomFactor = fabs(zoomFactor); 
		previousDistance = distance;
		self.robotLayer.transform = CATransform3DMakeScale(zoomFactor, zoomFactor, 1.0f);
	}
}
//END:code.PinchZoomView.touchesMoved

//START:code.PinchZoomView.touchesEnded
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if(event.allTouches.count != 2) {
		pinchZoom = NO;
		previousDistance = 0.0f;
	}
    if(event.allTouches.count == 1) {
//        NSArray *touches = [event.allTouches allObjects];
//        UITouch *touch = [touches objectAtIndex:0];
        UITouch *touch = [touches anyObject];
        
        
        NSInteger tapCount = [touch tapCount];
        if (tapCount == 2) {
            // 双击，
            zoomFactor += 0.4;
            self.robotLayer.transform = CATransform3DMakeScale(zoomFactor, zoomFactor, 1.0f);
        } else if (tapCount == 3) {
            // 三击，
            zoomFactor += 0.6;
            self.robotLayer.transform = CATransform3DMakeScale(zoomFactor, zoomFactor, 1.0f);
        } else if (tapCount == 4) {
            // 四击，
            zoomFactor += 0.8;
            self.robotLayer.transform = CATransform3DMakeScale(zoomFactor, zoomFactor, 1.0f);
        }
    }
}
//END:code.PinchZoomView.touchesEnded

- (void)dealloc {
	self.robotLayer = nil;
//	[robotLayer release];
//	[super dealloc];
}


@end
