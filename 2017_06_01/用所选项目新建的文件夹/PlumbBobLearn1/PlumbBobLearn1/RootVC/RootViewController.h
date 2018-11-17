//
//  RootViewController.h
//  PlumbBobLearn1
//
//  Created by xiaoyulong on 2017/5/22.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIAccelerometerDelegate>
{
    UIImageView* plumbBobView;
}
- (void)rotatePlumbStringToDegree:(CGFloat)positionInDegrees;
@end

CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);
