//
//  MultiTapView.m
//  MultiTap
//
//  Created by Bill Dudney on 6/27/08.
//  Copyright 2008 Gala Factory. All rights reserved.
//
//
//  Licensed with the Apache 2.0 License
//  http://apache.org/licenses/LICENSE-2.0
//

#import "MultiTapView.h"


@implementation MultiTapView


- (void)turnBlue {
  self.backgroundColor = [UIColor blueColor];
}

- (void)turnRed {
  self.backgroundColor = [UIColor redColor];
}

//START:code.MultiTapView.touchesBegan:
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if(touch.tapCount == 2) {
	  [[self class] cancelPreviousPerformRequestsWithTarget:self 
                                                 selector:@selector(turnRed) 
                                                   object:nil];
  }
}
//END:code.MultiTapView.touchesBegan:

//START:code.MultiTapView.touchesEnded:
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  if(touch.tapCount == 1) {
	  [self performSelector:@selector(turnRed) withObject:nil afterDelay:0.10f];
  }
  if(touch.tapCount == 2) {
	  [self turnBlue];
  }
}
//END:code.MultiTapView.touchesEnded:

@end
