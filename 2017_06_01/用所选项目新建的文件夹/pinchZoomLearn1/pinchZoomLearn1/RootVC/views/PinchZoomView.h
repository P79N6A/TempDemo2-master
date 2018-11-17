//
//  PinchZoomView.h
//  PinchZoom
//
//  Created by Bill Dudney on 7/3/08.
//  Copyright 2008 Gala Factory. All rights reserved.
//
//
//  Licensed with the Apache 2.0 License
//  http://apache.org/licenses/LICENSE-2.0
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PinchZoomView : UIView {
    CALayer *robotLayer;
    CGFloat previousDistance;
    CGFloat zoomFactor;
    BOOL pinchZoom;
}

@property(nonatomic, retain) CALayer *robotLayer;

@end
