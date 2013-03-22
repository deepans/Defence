//
//  MyCampBackgroundLayer.m
//  Defence
//
//  Created by Deepan Subramani on 17/01/13.
//
//

#import "MyCampBackgroundLayer.h"
#import "Shader.h"
#import "ColorHelper.h"
#import "Helper.h"


@implementation MyCampBackgroundLayer

-(void) setupShader{
	self.shaderProgram = [[CCShaderCache sharedShaderCache] programForKey:kCCShader_PositionColor];
}


-(CCSprite *)spriteWithColor:(ccColor4F) color size:(CGSize) size having:(int) stripeCount stripesColored:(ccColor4F) stripeColor {
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:size.width height:size.height];
    [rt beginWithClear:color.r g:color.g b:color.b a:color.a];
    
    CC_NODE_DRAW_SETUP();
    
    [Shader draw:stripeCount stripesOfColor:stripeColor withinTextureOfSize:size];
    [Shader addGradientToLayerWithTextureSize:size];
//    [Shader addTopHighLightForTextureWithSize:size];
    [Shader addNoiseFrom:@"Noise.png" toTextureWithSize:size];
    
    [rt end];
    
    return [CCSprite spriteWithTexture:rt.sprite.texture];
}

- (void)genBackground {
    ccColor4F bgColor = [ColorHelper sand];
    ccColor4F bgStripeColor = [ColorHelper sand];
    
    [_background removeFromParentAndCleanup:YES];
    [self setupShader];
    
    int nStripes = 5;
    _background = [self spriteWithColor:bgColor size:[[CCDirector sharedDirector] winSize] having:nStripes stripesColored:bgStripeColor];
    
    self.scale = 1;
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    _background.position = ccp(winSize.width/2, winSize.height/2);
    ccTexParams tp = {GL_LINEAR, GL_LINEAR, GL_CLAMP_TO_EDGE, GL_CLAMP_TO_EDGE};
    [_background.texture setTexParameters:&tp];
    
    [self addChild:_background];
}

-(id) init {
    if((self=[super init])) {
        [self genBackground];
    }
    return self;
}



- (void) dealloc
{
	[super dealloc];
}

@end
