//
//  ShootingRange.m
//  Defence
//
//  Created by Deepan Subramani on 18/01/13.
//
//

#import "ShootingRangeController.h"
#import "cocos2d.h"

@implementation ShootingRangeController{
    float range;
    CCSprite *sprite;
}

+(id)nodeWithRange:(float)range{
    return [[[ShootingRangeController alloc] initWithRange:range] autorelease];
}

- (void)pulseRange
{
    sprite.color = ccc3(218, 165, 91);
    CCTintTo *fadeIn = [CCTintTo actionWithDuration:1 red:183 green:154 blue:83];
    CCTintTo *fadeOut = [CCTintTo actionWithDuration:1 red:218 green:165 blue:91];
    
    CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
    [sprite runAction:repeat];
}

-(void) renderRanage{
    sprite = [CCSprite spriteWithFile:@"soldier_range.png"];
    sprite.position = CGPointMake(72, 35);
    [self pulseRange];
    [self addChild:sprite];
}

-(id) initWithRange:(float) _range {
    if((self=[super init])) {
        range = _range;
        [self renderRanage];
    }
    return self;
}


@end
