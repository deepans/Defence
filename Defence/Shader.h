//
//  Shader.h
//  Defence
//
//  Created by Deepan Subramani on 16/01/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Shader : NSObject
+(void) addGradientToLayerWithTextureSize: (CGSize) size;
+(void) draw:(int) stripesCount stripesOfColor:(ccColor4F) color withinTextureOfSize:(CGSize) size;
+(void) addTopHighLightForTextureWithSize:(CGSize) size;
+(void) addNoiseFrom:(NSString *) noiseFileName toTextureWithSize:(CGSize) size;
@end
