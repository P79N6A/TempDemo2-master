//
//  XLPoint.h
//  SpheresLearn1
//
//  Created by xiaoyulong on 2017/6/2.
//  Copyright © 2017年 xiaoyulong. All rights reserved.
//

#ifndef XLPoint_h
#define XLPoint_h


struct XLPoint {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};

typedef struct XLPoint XLPoint;


XLPoint XLPointMake(CGFloat x, CGFloat y, CGFloat z) {
    XLPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}



#endif /* XLPoint_h */
