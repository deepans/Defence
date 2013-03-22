//
//  Helper.m
//  Defence
//
//  Created by Deepan Subramani on 16/01/13.
//
//

#import "Helper.h"

@implementation Helper
+ (ccColor4F)randomBrightColor{
    
    while (true) {
        float requiredBrightness = 192;
        ccColor4B randomColor =
        ccc4(arc4random() % 255,
             arc4random() % 255,
             arc4random() % 255,
             255);
        if (randomColor.r > requiredBrightness ||
            randomColor.g > requiredBrightness ||
            randomColor.b > requiredBrightness) {
            return ccc4FFromccc4B(randomColor);
        }
    }
}

+(CGFloat) angleBetweenLineStarting: (CGPoint) startOfLineOne ending: (CGPoint) endOfLineOne  andLineStarting: (CGPoint) startOfLineTwo andEnding: (CGPoint) endOfLineTwo {
	
	CGFloat a = endOfLineOne.x - startOfLineOne.x;
	CGFloat b = endOfLineOne.y - startOfLineOne.y;
	CGFloat c = endOfLineTwo.x - startOfLineTwo.x;
	CGFloat d = endOfLineTwo.y - startOfLineTwo.y;
    
    CGFloat line1Slope = (endOfLineOne.y - startOfLineOne.y) / (endOfLineOne.x - startOfLineOne.x);
    CGFloat line2Slope = (endOfLineTwo.y - startOfLineTwo.y) / (endOfLineTwo.x - startOfLineTwo.x);
	
	CGFloat degs = acosf(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
	
    
	return (line2Slope > line1Slope) ? degs : -degs;
}


+(float) angleBetweenPoint: (CGPoint) point1 andPoint: (CGPoint) point2{
    float angle = atan2(point1.y - point2.y, point1.x - point2.x) * 180 / M_PI;
    if(angle < 0)
        angle = fabsf(angle);
    else if (angle != 0)
        angle = 360 - angle;
    return angle;
}


+(CGFloat) distanceBetweenPoint: (CGPoint) point1 andPoint:(CGPoint) point2
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy );
};


+(NSArray *) generatePathForZombieToWalkFrom:(CGPoint) point1 to:(CGPoint) point2{
    NSMutableArray *path = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:point1], nil];
    [Helper generateDiversionBetween:point1 and:point2 andAddToPath:path];
    return [NSArray arrayWithArray:[Helper ziczacPath:path]];
}

+(CGPoint) thirdVertexOfIsoscelesTriangleGivenFirstVertexOfBaseAs:(CGPoint) vertex1 secondVertexOfBaseAs: (CGPoint) vertex2 altitude:(float) altitude andDirection:(float) direction{
    
    float angleBetweenTwoPointsClockwise = [Helper angleBetweenPoint:vertex1 andPoint:vertex2];
    float angleBetweenTwoPointsCounterClockwise = angleBetweenTwoPointsClockwise < 180 ? 180 - angleBetweenTwoPointsClockwise : 540 - angleBetweenTwoPointsClockwise;

    angleBetweenTwoPointsCounterClockwise = angleBetweenTwoPointsCounterClockwise + (direction + 90);
    float angle = CC_DEGREES_TO_RADIANS(angleBetweenTwoPointsCounterClockwise);
    
    
    CGPoint midpoint = CGPointMake((vertex1.x + vertex2.x) / 2, (vertex1.y + vertex2.y) / 2);
    
    return CGPointMake(midpoint.x + altitude * cos(angle), midpoint.y + altitude * sin(angle));
}

+(CGPoint) thirdVertexOfIsoscelesTriangleOnTheRightSideGivenFirstVertexOfBaseAs:(CGPoint) vertex1 secondVertexOfBaseAs: (CGPoint) vertex2 andAltitude:(float) altitude{
    return [Helper thirdVertexOfIsoscelesTriangleGivenFirstVertexOfBaseAs:vertex1 secondVertexOfBaseAs:vertex2 altitude:altitude andDirection:1];
}

+(CGPoint) thirdVertexOfIsoscelesTriangleOnTheLeftSideGivenFirstVertexOfBaseAs:(CGPoint) vertex1 secondVertexOfBaseAs: (CGPoint) vertex2 andAltitude:(float) altitude{
    return [Helper thirdVertexOfIsoscelesTriangleGivenFirstVertexOfBaseAs:vertex1 secondVertexOfBaseAs:vertex2 altitude:altitude andDirection:-1];
}


+(NSArray *) ziczacPath:(NSArray *) path{
    if(path.count > 1){
        NSMutableArray *ziczacPath = [NSMutableArray array];
        for (int i = 0; i < path.count; i++) {
            CGPoint start = [((NSValue *) path[i]) CGPointValue];
            CGPoint end = [((NSValue *) path[i + 1]) CGPointValue];
            if(i != path.count - 2){
                float distanceBetweenStartAndEnd = [Helper distanceBetweenPoint:start andPoint:end];
                float deviationDistance = distanceBetweenStartAndEnd / 7;
                [ziczacPath addObject:[NSValue valueWithCGPoint:start]];
                switch ([Helper randomNumberBetween:0 and:2]) {
                    case 0:
                        // left
                        [ziczacPath addObject:[NSValue valueWithCGPoint:[Helper thirdVertexOfIsoscelesTriangleOnTheLeftSideGivenFirstVertexOfBaseAs:start secondVertexOfBaseAs:end andAltitude:deviationDistance]]];
                        break;
                    case 1:
                        // right
                        [ziczacPath addObject:[NSValue valueWithCGPoint:[Helper thirdVertexOfIsoscelesTriangleOnTheRightSideGivenFirstVertexOfBaseAs:start secondVertexOfBaseAs:end andAltitude:deviationDistance]]];
                        break;
                    default:
                        // straight
                        break;
                }
            }else{
                [ziczacPath addObject:[NSValue valueWithCGPoint:start]];
                [ziczacPath addObject:[NSValue valueWithCGPoint:end]];
                break;
            }
        }
        return ziczacPath;
    }else{
        return path;
    }
}

+(int) randomNumberBetween:(int) lowerBound and:(int) upperBound{
    return lowerBound + arc4random() % (upperBound - lowerBound);
}


+(void) generateDiversionBetween: (CGPoint) point1 and:(CGPoint) point2 andAddToPath:(NSMutableArray *) path{
    int minDistanceWhenADiversionIsAllowed = 150;
    float distance = [Helper distanceBetweenPoint:point1 andPoint:point2];
    if(distance > minDistanceWhenADiversionIsAllowed){
        int hopDistance = [Helper randomNumberBetween:minDistanceWhenADiversionIsAllowed and:distance];
        
        float x3 = point2.x - point1.x;
        float y3 = point2.y - point1.y;
        
        float length = sqrtf(x3 * x3 + y3 * y3);
        
        x3 /= length;
        y3 /= length;
            
        x3 *= hopDistance;
        y3 *= hopDistance;
        
        CGPoint hop = CGPointMake(point1.x + x3, point1.y + y3);
        [path addObject:[NSValue valueWithCGPoint:hop]];
        
        [Helper generateDiversionBetween:hop and:point2 andAddToPath:path];
    }else
        [path addObject:[NSValue valueWithCGPoint:point2]];
}

+(BOOL) isCollisionBetweenSpriteA:(CCSprite*)spr1 spriteB:(CCSprite*)spr2 pixelPerfect:(BOOL)pp
{
    
    
    BOOL isCollision = NO;
    CGRect intersection = CGRectIntersection([spr1 boundingBox], [spr2 boundingBox]);
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:400 height:400];
    // Look for simple bounding box collision
    if (!CGRectIsEmpty(intersection))
    {
        // If we're not checking for pixel perfect collisions, return true
        if (!pp) {return YES;}
        
        // Get intersection info
        unsigned int x = intersection.origin.x;
        unsigned int y = intersection.origin.y;
        unsigned int w = intersection.size.width;
        unsigned int h = intersection.size.height;
        unsigned int numPixels = w * h;
        
        // Draw into the RenderTexture
        [rt beginWithClear:0 g:0 b:0 a:0];
        
        // Render both sprites: first one in RED and second one in GREEN
        glColorMask(1, 0, 0, 1);
        [spr1 visit];
        glColorMask(0, 1, 0, 1);
        [spr2 visit];
        glColorMask(1, 1, 1, 1);
        
        // Read pixels
        ccColor4B *buffer = malloc( sizeof(ccColor4B) * numPixels );
//        CGSize winSize = [[CCDirector sharedDirector] winSize];
        glReadPixels(x, y, w, h, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
        
        [rt end];
        
        // Read buffer
        unsigned int step = 1;
        for(unsigned int i=0; i<numPixels; i+=step)
        {
            ccColor4B color = buffer[i];
            
            if (color.r > 0 && color.g > 0)
            {
                isCollision = YES;
                break;
            }
        }
        
        // Free buffer memory
        free(buffer);
    }
    
    return isCollision;
}

@end
