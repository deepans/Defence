//
//  Helper.h
//  Defence
//
//  Created by Deepan Subramani on 16/01/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Helper : NSObject
+ (ccColor4F)randomBrightColor;
+(CGFloat) angleBetweenLineStarting: (CGPoint) startOfLineOne ending: (CGPoint) endOfLineOne  andLineStarting: (CGPoint) startOfLineTwo andEnding: (CGPoint) endOfLineTwo;
+(CGFloat) distanceBetweenPoint: (CGPoint) point1 andPoint:(CGPoint) point2;
+(float) angleBetweenPoint: (CGPoint) point1 andPoint: (CGPoint) point2;
+(NSArray *) generatePathForZombieToWalkFrom:(CGPoint) point1 to:(CGPoint) point2;
+(BOOL) isCollisionBetweenSpriteA:(CCSprite*)spr1 spriteB:(CCSprite*)spr2 pixelPerfect:(BOOL)pp;
@end
