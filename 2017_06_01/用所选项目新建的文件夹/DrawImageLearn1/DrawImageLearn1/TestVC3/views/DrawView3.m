//
//  DrawView3.m
//  Draw
//
//  Created by Bill Dudney on 6/26/08.
//  Copyright 2008 Gala Factory. All rights reserved.
//
//
//  Licensed with the Apache 2.0 License
//  http://apache.org/licenses/LICENSE-2.0
//

#import "DrawView3.h"
#import "Dot.h"

@implementation DrawView3

@synthesize dots;

- (NSMutableArray *)dots {
  if(nil == dots) {
    self.dots = [NSMutableArray array];
  }
  return dots;
}

//START:code.DrawView.multi.touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *anyTouch = [touches anyObject];
  if(anyTouch.tapCount > 1) {
    self.dots = nil;
    [self setNeedsDisplay];
    return;
  }
  BOOL needsDraw = NO;
  for(UITouch *touch in event.allTouches) { //<label id="code.DrawView.touches"/>
    if(UITouchPhaseBegan == touch.phase) {//<label id="code.DrawView.touch.began"/>
      CGPoint location = [touch locationInView:self];
      Dot *dot = [[Dot alloc] init];
      dot.x = location.x;
      dot.y = location.y;
      [self.dots addObject:dot];
      needsDraw = YES;
    }
  }
  if(needsDraw) {
    [self setNeedsDisplay];
  }
}
//END:code.DrawView.multi.touchesBegan

//START:code.DrawView.multi.touchesMoved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  BOOL needsDraw = NO;
  for(UITouch *touch in event.allTouches) {
    if(UITouchPhaseStationary != touch.phase) {//<label id="code.DrawView.not.stationary"/>
      CGPoint location = [touch locationInView:self];
      Dot *dot = [[Dot alloc] init];
      dot.x = location.x;
      dot.y = location.y;
      [self.dots addObject:dot];
      needsDraw = YES;
    }
  }
  if(needsDraw) {
    [self setNeedsDisplay];
  }
}
//END:code.DrawView.multi.touchesMoved

- (void)drawRect:(CGRect)rect {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(ctx, [[UIColor blueColor] CGColor]);
  for(Dot *dot in self.dots) {
    CGContextAddArc(ctx, dot.x, dot.y, 5.0f, 0.0f, 2.0f * M_PI, YES);
    CGContextFillPath(ctx);
  }
}

- (void)dealloc
{
    self.dots = nil;
//	[super dealloc];
}


@end
