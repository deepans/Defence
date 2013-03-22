//
//  ControlPanelLayer.m
//  Defence
//
//  Created by Deepan Subramani on 18/01/13.
//
//

#import "ControlPanelLayer.h"
#import "cocos2d.h"

@implementation ControlPanelLayer{
    CCSprite *newSoldier;
}

@synthesize delegate;

-(void) loadPanel{
    newSoldier = [CCSprite spriteWithFile:@"aiming_soldier.png"];
    newSoldier.scale = 0.3;
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    newSoldier.position = CGPointMake(0.05 * windowSize.width, .92 * windowSize.height);
    [self addChild:newSoldier];
}


-(void) cleanup{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}


-(id) init {
    if((self=[super init])) {
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        [self loadPanel];
    }
    return self;
}

-(BOOL) intendedToAddNewSoldier: (CGPoint) touchLocation{
    return CGRectContainsPoint(newSoldier.boundingBox, touchLocation);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    if([self intendedToAddNewSoldier:touchLocation]){
        [self.delegate addNewSoldier:touchLocation];
    }
    return NO;
}


@end
