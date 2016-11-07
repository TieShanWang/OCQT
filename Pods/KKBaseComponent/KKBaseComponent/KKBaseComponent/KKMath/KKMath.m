//
//  KKMath.m
//  KKPoint
//
//  Created by KING on 16/9/1.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "KKMath.h"

#import <AVFoundation/AVFoundation.h>

CGRect KKMakeRectWithAspectRatioInsideRect(CGSize aspectRatio, CGRect boundingRect){
    return AVMakeRectWithAspectRatioInsideRect(aspectRatio, boundingRect);
}

void KKLogTransform(CGAffineTransform form){
    printf("\na = %f \nb = %f\nc = %f\nd = %f\ntx = %f\nty = %f\n",form.a,form.b,form.c,form.d,form.tx,form.ty);
}

CGAffineTransform KKTransformMakeWith(CGFloat tx, CGFloat ty, CGFloat scale, CGFloat rotation)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, tx, ty);
    transform = CGAffineTransformScale(transform, scale, scale);
    transform = CGAffineTransformRotate(transform, rotation);
    return transform;
}

CGFloat KKDegreeToRadian(CGFloat degrees)
{
    return (degrees / 180.0) * M_PI;
}

CGFloat KKRadianToDegree(CGFloat radian)
{
    return (radian / M_PI) * 180.0;
}

CGPoint KKPointMultiNum(CGPoint point, CGFloat multiple)
{
    return CGPointMake(point.x * multiple, point.y * multiple);
}

CGFloat KKTransToMinTwoPI(CGFloat angle){
    
    CGFloat resultAngle = angle;
    
    // 简化为360度内
    if (resultAngle > 2 * M_PI) {
        // 相除结果
        CGFloat tmp = resultAngle / (2 * M_PI);
        // 取整数
        CGFloat z = floor(tmp);
        // 取小数 * 2 * M_PI
        resultAngle = (tmp - z) * (2 * M_PI);
    }
    
    return resultAngle;
}

CGFloat KKDisTwoPoint(CGPoint p1, CGPoint p2){
    return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}

// 参考点为原点
CGFloat KKAngleAtPoint(CGPoint point){

    CGFloat x = point.x;
    CGFloat y = point.y;
    
    CGFloat abx = fabs(point.x);
    CGFloat aby = fabs(point.y);
    
    CGFloat angle = 0;
    
    if (x == 0 || y == 0) {
        if (x == 0 && (y == 0)) {
            angle = 0;
        }else if (x == 0 && (y != 0) ){
            angle = (y > 0)? M_PI / 2.0 : M_PI * 1.5;
        }else if(y == 0 && (x != 0)){
            angle = (x > 0)? 0 : M_PI;
        }
        return angle;
    }
    
    if (x > 0 && y > 0) {
        // 第一象限
        angle = atan(aby / abx);
    }else if (x > 0 && y < 0){
        // 第四象限
        angle =  2 * M_PI - atan(aby / abx);
    }else if (x < 0 && y > 0){
        // 第二象限
        angle = M_PI / 2.0 + atan(abx / aby);
    }else if(x < 0 && y < 0){
        // 第三象限
        angle = M_PI + atan( aby / abx);
    }
    return angle;
}

CGFloat KKDistancePointToLine(CGPoint lineP1, CGPoint lineP2, CGPoint p){
    
    CGFloat A,B,C = 0;
    
    A = lineP2.y - lineP1.y;
    B = lineP1.x - lineP2.x;
    C = lineP2.x * lineP1.y - lineP1.x * lineP2.y;
    
    //    [self getLint:&A B:&B C:&C Point1:point1 point2:point2];
    
    CGFloat dist = 0;
    
    // a^2 +  b^2
    CGFloat fz = sqrt( A * A + B * B);
    
    // ax + by + c
    CGFloat fm = A * p.x + B * p.y + C;
    
    dist = fz ? fabs(fm / fz) : 0;
    
    return dist;
}

void KKGetLine(CGFloat * A, CGFloat * B, CGFloat * C, CGPoint lineP1, CGPoint lineP2){

    CGFloat a,b,c = 0;
    
    a = lineP2.y - lineP1.y;
    b = lineP1.x - lineP2.x;
    c = lineP2.x * lineP1.y - lineP1.x * lineP2.y;
    
    A = &a;
    B = &b;
    C = &c;
}

CGPoint KKPointAddPoint(CGPoint p1, CGPoint p2){
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

CGPoint KKPointRelatePoint(CGPoint baseP, CGPoint relativeP){
    return CGPointMake(relativeP.x - baseP.x, relativeP.y - baseP.y);
}

CGPoint KKCenterAtFrame(CGRect frame){
    return CGPointMake(frame.origin.x + frame.size.width / 2.0, frame.origin.y + frame.size.height / 2.0);
}

CGAffineTransform KKGetTransformComponent(CGAffineTransform transform)
{
    CGAffineTransform newTransform = CGAffineTransformIdentity;
    CGFloat ang = atanf(transform.b/transform.a);
    if (sinf(ang) == 0) {
        newTransform.a = transform.a;
        newTransform.d = transform.a;
    }else{
        newTransform.a = transform.b/sinf(ang);
        newTransform.d = transform.b/sinf(ang);
    }
    newTransform.b = ang * 180 / M_PI;
    newTransform.c = ang * 180 / M_PI;
    newTransform.tx = transform.tx;
    newTransform.ty = transform.ty;
    return newTransform;
}


#pragma mark - center by anchor point

CGPoint const KKAnchorPointLeftTop = {0,0};
CGPoint const KKAnchorPointLeftBottom = {0,1};
CGPoint const KKAnchorPointRightTop = {1,0};
CGPoint const KKAnchorPointRightBottom = {1,1};
CGPoint KKRectCenterChangeWithAnchorPoint(KKAnchorPoint anchorPoint, CGRect frame, CGAffineTransform transform)
{
    static UIView * assistView;
    if (!assistView) {
        assistView = [[UIView alloc]init];
    }
    assistView.layer.anchorPoint = anchorPoint;
    assistView.transform = CGAffineTransformIdentity;
    assistView.frame = frame;
    assistView.transform = transform;
    CGPoint point = CGPointMake(KKCenterAtFrame(assistView.frame).x - KKCenterAtFrame(frame).x, KKCenterAtFrame(assistView.frame).y - KKCenterAtFrame(frame).y);
    return point;
}
CGPoint KKRectTSRCenterChangeWithAnchorPoint(KKAnchorPoint anchorPoint, CGRect frame, CGPoint transtion, CGFloat scale, CGFloat rotation)
{
    return KKRectCenterChangeWithAnchorPoint(anchorPoint, frame, KKTransformMakeWith(transtion.x, transtion.y,scale, rotation));
}

CGPoint KKRectScaleCenterChangeWithAnchorPoint(KKAnchorPoint anchorPoint, CGRect frame, CGFloat scale)
{
    return KKRectTSRCenterChangeWithAnchorPoint(anchorPoint, frame, CGPointZero, scale, 0);
}

CGPoint KKRectRotationCenterChangeWithAnchorPoint(KKAnchorPoint anchorPoint, CGRect frame, CGFloat rotation)
{
    return KKRectTSRCenterChangeWithAnchorPoint(anchorPoint, frame, CGPointZero, 1, rotation);
}


CGAffineTransform KKCMGetTransformForSVG(CGRect frame, CGAffineTransform transform){
    
    CGAffineTransform newTransform = transform;
    
    // 原始左上角
    CGPoint oriTopLeft = frame.origin;
    
    // 原始中心
    CGPoint oriCenter = KKCenterAtFrame(frame);
    
    // 现在中心
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.transform = newTransform;
    CGPoint curCenter = KKCenterAtFrame(view.frame);
    
    // 现在左上角q
    CGPoint offset = KKPointRelatePoint(oriCenter, oriTopLeft);
    CGAffineTransform tmpTransform = newTransform;
    tmpTransform.tx = 0;
    tmpTransform.ty = 0;
    CGPoint newOffset =  CGPointApplyAffineTransform(offset, tmpTransform);
    CGPoint curTopLeft = KKPointAddPoint(curCenter ,newOffset);
    
    CGFloat tx = curTopLeft.x;
    CGFloat ty = curTopLeft.y;
    
    newTransform.tx = tx;
    newTransform.ty = ty;
    
    return newTransform;
    
}

CGFloat CMGetAfterRange(CGRect oldRect ,CGAffineTransform transform) {
    
    CGPoint pointA = CGPointMake(oldRect.origin.x, oldRect.origin.y);
    CGPoint pointB = CGPointMake(oldRect.origin.x + oldRect.size.width, oldRect.origin.y);
    CGPoint pointC = CGPointMake(oldRect.origin.x, oldRect.origin.y + oldRect.size.height);
    CGPoint pointD = CGPointMake(oldRect.origin.x + oldRect.size.width, oldRect.origin.y + oldRect.size.height);
    
    CGPoint newPointA = CGPointZero;
    newPointA.x = transform.a * pointA.x + transform.c * pointA.y + transform.tx;
    newPointA.y = transform.b * pointA.x + transform.d * pointA.y + transform.ty;
    
    CGPoint newPointB = CGPointZero;
    newPointB.x = transform.a * pointB.x + transform.c * pointB.y + transform.tx;
    newPointB.y = transform.b * pointB.x + transform.d * pointB.y + transform.ty;
    
    CGPoint newPointC = CGPointZero;
    newPointC.x = transform.a * pointC.x + transform.c * pointC.y + transform.tx;
    newPointC.y = transform.b * pointC.x + transform.d * pointC.y + transform.ty;

    CGPoint newPointD = CGPointZero;
    newPointD.x = transform.a * pointD.x + transform.c * pointD.y + transform.tx;
    newPointD.y = transform.b * pointD.x + transform.d * pointD.y + transform.ty;

    CGFloat width = KKDisTwoPoint(newPointA, newPointB);
    CGFloat height = KKDisTwoPoint(newPointA, newPointC);

    return width * height;
}

CGAffineTransform KKCMGetTransformLeftBotmForSVG(CGRect frame, CGAffineTransform transform){
    
    CGAffineTransform newTransform = transform;
    
    // 原始左下角
    CGPoint oriTopLeft = CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame));
    
    // 原始中心
    CGPoint oriCenter = KKCenterAtFrame(frame);
    
    // 现在中心
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.transform = newTransform;
    CGPoint curCenter = KKCenterAtFrame(view.frame);
    
    // 现在左下角
    CGPoint offset = KKPointRelatePoint(oriCenter, oriTopLeft);
    CGAffineTransform tmpTransform = newTransform;
    tmpTransform.tx = 0;
    tmpTransform.ty = 0;
    CGPoint newOffset =  CGPointApplyAffineTransform(offset, tmpTransform);
    CGPoint curTopLeft = KKPointAddPoint(curCenter ,newOffset);
    
    CGFloat tx = curTopLeft.x;
    CGFloat ty = curTopLeft.y;
    
    newTransform.tx = tx;
    newTransform.ty = ty;
    
    return newTransform;
    
}

CGRect CGZeroXYRectByWH(CGFloat width, CGFloat height){
    return CGRectMake(0, 0, width, height);
}

CGRect CGZeroXYRectBySize(CGSize size){
    return CGRectMake(0, 0, size.width, size.height);
}

CGRect CGRectFitSizeWithContentMode(CGSize superSize, CGSize size, UIViewContentMode contentMode){
    switch (contentMode) {
            
        case UIViewContentModeTop:
            return CGRectMake((superSize.width - size.width) / 2.0f, 0, size.width, size.height);
            break;
            
        case UIViewContentModeLeft:
            return CGRectMake(0, (superSize.height - size.height) / 2.0f, size.width, size.height);
            break;
            
        case UIViewContentModeRight:
            return CGRectMake(superSize.width - size.width, (superSize.height - size.height) / 2.0, size.width, size.height);
            break;
            
        case UIViewContentModeBottom:
            return CGRectMake((superSize.width - size.width) / 2.0, superSize.height - size.height, size.width, size.height);
            break;
            
        case UIViewContentModeCenter:
            return CGRectMake((superSize.width - size.width) / 2.0, (superSize.height - size.height) / 2.0, size.width, size.height);
            break;
            
        case UIViewContentModeTopLeft:
            return CGZeroXYRectBySize(size);
            break;
            
        case UIViewContentModeTopRight:
            return CGRectMake(superSize.width - size.width, 0, size.width, size.height);
            break;
            
        case UIViewContentModeBottomLeft:
            return CGRectMake(0, superSize.height - size.height, size.width, size.height);
            break;
            
        case UIViewContentModeBottomRight:
            return CGRectMake(superSize.width - size.width, superSize.height - size.height, size.width, size.height);
            break;
            
        case UIViewContentModeRedraw:
        case UIViewContentModeScaleToFill:
            return CGZeroXYRectBySize(superSize);
            break;
        case UIViewContentModeScaleAspectFit:
        {
            CGFloat radio = size.width / size.height;
            if (size.width / superSize.width >= size.height / superSize.height) {
                CGFloat realHeight = superSize.width / radio;
                return CGRectMake(0, (superSize.height - realHeight) / 2.0, superSize.width, realHeight);
            }else{
                CGFloat realWidth = superSize.height * radio;
                return CGRectMake((superSize.width - realWidth) / 2.0, 0, realWidth, superSize.height);
            }
            break;
        }
        case UIViewContentModeScaleAspectFill:
        {
            CGFloat radio = size.width / size.height;
            if (size.width / superSize.width <= size.height / superSize.height) {
                CGFloat realHeight = superSize.width / radio;
                return CGRectMake(0, (superSize.height - realHeight) / 2.0, superSize.width, realHeight);
            }else{
                CGFloat realWidth = superSize.height * radio;
                return CGRectMake((superSize.width - realWidth) / 2.0, 0, realWidth, superSize.height);
            }
            break;
        }
        default:
            break;
    }
}



CGRect CGRectConvertToSizeSelfSize(CGRect rect, CGSize targetSize){
    
    CGRect newFrame;
    
    CGFloat newW,newH,newX,newY = 0;
    
    CGFloat SX = rect.origin.x;
    CGFloat SY = rect.origin.y;
    CGFloat SW = rect.size.width;
    CGFloat SH = rect.size.height;
    
    CGFloat PW = targetSize.width;
    CGFloat PH = targetSize.height;
    
    if (SY > 0) {
        newY = 0;
        if (SH + SY > PH) {
            newH = PH - SY;
        }else{
            newH = SH;
        }
    }else{
        newY = (SY)?-SY:0;
        if (SH + SY > PH) {
            newH = PH;
        }else{
            newH = SH + SY;
        }
    }
    
    
    if (SX > 0) {
        newX = 0;
        if (SW + SX > PW) {
            newW = PW - SX;
        }else{
            newW = SW;
        }
    }else{
        newX = (SX)?-SX:0;
        if (SW + SX > PW) {
            newW = PW;
        }else{
            newW = SW + SX;
        }
    }
    
    newFrame.origin = CGPointMake(newX, newY);
    newFrame.size = CGSizeMake(newW, newH);
    
    return newFrame;
    
}
