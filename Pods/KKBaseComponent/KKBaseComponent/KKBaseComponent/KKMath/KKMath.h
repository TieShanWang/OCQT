//
//  KKMath.h
//  KKPoint
//
//  Created by KING on 16/9/1.
//  Copyright © 2016年 KING. All rights reserved.
//


#ifndef KK_Math
#define KK_Math

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 *  log the special transform with form like this:
 *  a = *
 *  b = *
 *  c = *
 *  d = *
 *  tx = *
 *  ty = *
 *
 *  @param transform to be log
 */
void KKLogTransform(CGAffineTransform transform);

/**
 according tx,ty,scale,r to get a transform

 @param tx       tx
 @param ty       ty
 @param scale    scale
 @param rotation r

 @return new transform
 */
CGAffineTransform KKTransformMakeWith(CGFloat tx, CGFloat ty, CGFloat scale, CGFloat rotation);

/**
 transposition degrees to radian
 
 @param degrees degrees
 
 @return radian
 */
CGFloat KKDegreeToRadian(CGFloat degrees);

/**
 transposition radian to degrees

 @param radian radian

 @return degrees
 */
CGFloat KKRadianToDegree(CGFloat radian);

/**
 CGPoint multi one num

 @param multiple multipe

 @return new CGPoint
 */
CGPoint KKPointMultiNum(CGPoint point, CGFloat multiple);

/**
 *  get the center of special frame
 *
 *  @param frame to be cul
 *
 *  @return center
 */
CGPoint KKCenterAtFrame(CGRect frame);

/**
 *  point add point
 *  {point1.x + point2.x, point1.y + point2.y}
 *
 *  @param p1 first point
 *  @param p2 second point
 *
 *  @return sum of two points
 */
CGPoint KKPointAddPoint(CGPoint p1, CGPoint p2);

/**
 *  The baseP point as the origin point, get the position of relativeP
 *
 *  @param baseP     which to be the orgin point
 *  @param relativeP relativeP
 *
 *  @return relative point
 */
CGPoint KKPointRelatePoint(CGPoint baseP, CGPoint relativeP);

/**
 *  To get a matrix of SVG format
 *
 *  @param frame            the origin frame
 *  @param currentTransform the transform
 *
 *  @return CGAffineTransform
 */
CGAffineTransform KKCMGetTransformForSVG(CGRect frame, CGAffineTransform transform);
CGAffineTransform KKCMGetTransformLeftBotmForSVG(CGRect frame, CGAffineTransform transform);


/**
 根据矩阵获取scale,rotation,tx,ty

 @param transform transform

 @return a transform contain real scale,rotation,tx,ty
 */
CGAffineTransform KKGetTransformComponent(CGAffineTransform transform);

/**
 *  see AVMakeRectWithAspectRatioInsideRect
 */
CGRect KKMakeRectWithAspectRatioInsideRect(CGSize aspectRatio, CGRect boundingRect) NS_AVAILABLE(10_7, 4_0);

/**
 *  distance of two points
 *
 *  @param p1 the first point
 *  @param p2 the second point
 *
 *  @return distance of the special two points
 */
CGFloat KKDisTwoPoint(CGPoint p1, CGPoint p2);

/**
 *  Will develop Angle reduction to less than 360 degrees
 *
 *  @param angle angle
 *
 *  @return angle less the 360 degrees
 */
CGFloat KKTransToMinTwoPI(CGFloat angle);

/**
 *  The specified point relative to the origin of the Angle
 *
 *  @param point The specified point
 *
 *  @return Angle
 */
CGFloat KKAngleAtPoint(CGPoint point);

/**
 *  Point to the straight line distance, Point lineP1 and point lineP2 decided to straight line
 *
 *  @param lineP1 a point of a line
 *  @param lineP2 a point of a line
 *  @param p      A point outside the line
 *
 *  @return distance
 */
CGFloat KKDistancePointToLine(CGPoint lineP1, CGPoint lineP2, CGPoint p);


/**
 *  According to two points to ensure a linear equations
 *  the A,B,C is Ax + By + c = 0
 *
 *  @param A      A
 *  @param B      B
 *  @param C      C
 *  @param lineP1 a point of a line
 *  @param lineP2 a point of a line
 */
void KKGetLine(CGFloat * A, CGFloat * B, CGFloat * C, CGPoint lineP1, CGPoint lineP2);

CGFloat CMGetAfterRange(CGRect oldRect ,CGAffineTransform transform);

CGRect CGZeroXYRectByWH(CGFloat width, CGFloat height);

CGRect CGZeroXYRectBySize(CGSize size);

CGRect CGRectFitSizeWithContentMode(CGSize superSize, CGSize size, UIViewContentMode contentMode);

/**
 *  将自己映射到一个矩形框中后，自身保留的位置
 *
 *  @param rect       自身在需要映射的矩形框中的位置
 *  @param targetSize 需要映射的矩形框
 *
 *  @return 保留frame
 */
CGRect CGRectConvertToSizeSelfSize(CGRect rect, CGSize targetSize);

#pragma mark - center by anchor point

typedef CGPoint KKAnchorPoint;
extern CGPoint const KKAnchorPointLeftTop;
extern CGPoint const KKAnchorPointLeftBottom;
extern CGPoint const KKAnchorPointRightTop;
extern CGPoint const KKAnchorPointRightBottom;
/**
 矩形框在指定锚点应用矩阵后中心点的变化
 rect center change apply transform

 @param anchorPoint anchor point
 @param frame       frame
 @param transform   transform

 @return center change
 */
CGPoint KKRectCenterChangeWithAnchorPoint(KKAnchorPoint anchorPoint, CGRect frame, CGAffineTransform transform);

CGPoint KKRectTSRCenterChangeWithAnchorPoint(KKAnchorPoint anchorPoint, CGRect frame, CGPoint transtion, CGFloat scale, CGFloat rotation);

CGPoint KKRectScaleCenterChangeWithAnchorPoint(KKAnchorPoint anchorPoint, CGRect frame, CGFloat scale);

CGPoint KKRectRotationCenterChangeWithAnchorPoint(KKAnchorPoint anchorPoint, CGRect frame, CGFloat rotation);
#endif

