//
//  Shader.m
//  Defence
//
//  Created by Deepan Subramani on 16/01/13.
//
//

#import "Shader.h"

@implementation Shader
+(void) addGradientToLayerWithTextureSize: (CGSize) size{
    CGPoint vertices[4];
    ccColor4F colors[4];
    float gradientAlpha = 0.3;
    int nVertices = 0;
    
    vertices[nVertices] = CGPointMake(0, 0);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0 };
    vertices[nVertices] = CGPointMake(size.width, 0);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0};
    vertices[nVertices] = CGPointMake(0, size.height);
    colors[nVertices++] = (ccColor4F){0, 0, 0, gradientAlpha};
    vertices[nVertices] = CGPointMake(size.width, size.height);
    colors[nVertices++] = (ccColor4F){0, 0, 0, gradientAlpha};
    
    glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
	glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_FLOAT, GL_FALSE, 0, colors);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)nVertices);
}

+(void) draw:(int) stripesCount stripesOfColor:(ccColor4F) color withinTextureOfSize:(CGSize) size{
    CGPoint vertices[stripesCount * 6];
    ccColor4F colors[stripesCount * 6];
    int nVertices = 0;
    float x1 = -size.width;
    float x2;
    float y1 = size.height;
    float y2 = 0;
    float dx = size.width / stripesCount * 2;
    float stripeWidth = dx/2;
    for (int i=0; i<stripesCount; i++) {
        x2 = x1 + size.width;
        vertices[nVertices] = CGPointMake(x1, y1);
        colors[nVertices++] = (ccColor4F){color.r, color.g, color.b, color.a};
        vertices[nVertices] = CGPointMake(x1+stripeWidth, y1);
        colors[nVertices++] = (ccColor4F){color.r, color.g, color.b, color.a};
        vertices[nVertices] = CGPointMake(x2, y2);
        colors[nVertices++] = (ccColor4F){color.r, color.g, color.b, color.a};
        vertices[nVertices] = vertices[nVertices-2];
        colors[nVertices++] = (ccColor4F){color.r, color.g, color.b, color.a};
        vertices[nVertices] = vertices[nVertices-2];
        colors[nVertices++] = (ccColor4F){color.r, color.g, color.b, color.a};
        vertices[nVertices] = CGPointMake(x2+stripeWidth, y2);
        colors[nVertices++] = (ccColor4F){color.r, color.g, color.b, color.a};
        x1 += dx;
    }
    
    glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_FLOAT, GL_FALSE, 0, colors);
    glDrawArrays(GL_TRIANGLES, 0, (GLsizei)nVertices);
    
}

+(void) addTopHighLightForTextureWithSize:(CGSize) size{
    CGPoint vertices[4];
    ccColor4F colors[4];
    
    float borderWidth = size.height/16;
    float borderAlpha = 0.3f;
    int nVertices = 0;
    
    vertices[nVertices] = CGPointMake(0, 0);
    colors[nVertices++] = (ccColor4F){1, 1, 1, borderAlpha};
    vertices[nVertices] = CGPointMake(size.width, 0);
    colors[nVertices++] = (ccColor4F){1, 1, 1, borderAlpha};
    
    vertices[nVertices] = CGPointMake(0, borderWidth);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0};
    vertices[nVertices] = CGPointMake(size.width, borderWidth);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0};
    
    glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
	glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_FLOAT, GL_FALSE, 0, colors);
    glBlendFunc(GL_DST_COLOR, GL_ONE_MINUS_SRC_ALPHA);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)nVertices);
    
}

+(void) addNoiseFrom:(NSString *) noiseFileName toTextureWithSize:(CGSize) size{
    CCSprite *noise = [CCSprite spriteWithFile:noiseFileName];
    [noise setBlendFunc:(ccBlendFunc){GL_DST_COLOR, GL_ZERO}];
    noise.position = ccp(size.width/2, size.height/2);
    [noise visit];
}

@end
