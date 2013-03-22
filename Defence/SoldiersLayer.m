//
//  SoldiersLayer.m
//  Defence
//
//  Created by Deepan Subramani on 17/01/13.
//
//

#import "SoldiersLayer.h"
#import "cocos2d.h"
#import "ShootingRangeController.h"
#import "Helper.h"
#import "Soldier.h"

@implementation SoldiersLayer{
    Soldier * selectedSoldier;
    Soldier * soldierSelectedForDrag;
    BOOL addingNewSoldier;
}

@synthesize world;

-(id) init {
    if((self=[super init])) {
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        self.isTouchEnabled = YES;
        addingNewSoldier = NO;
    }
    return self;
}

-(void) cleanup{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

-(void) addSoldier:(CGPoint) location{
    CCSprite *soldierSprite = [CCSprite spriteWithFile:@"soldier.png"];
    soldierSprite.position = location;
    soldierSprite.scale = 0.4;
    
    CCNode *shootingRange = [ShootingRangeController nodeWithRange:50];
    [soldierSprite addChild:shootingRange z:-1];

    addingNewSoldier = YES;
    [self addChild:soldierSprite];
    Soldier *soldier = [[Soldier alloc] initWithSprite:soldierSprite];
    soldierSelectedForDrag = soldier;
    selectedSoldier = soldier;
    
}

-(void) addNewSoldier: (CGPoint) origin{
    [self addSoldier:origin];
}

- (void)panForTranslation:(CGPoint)translation {
    if (soldierSelectedForDrag) {
        CGPoint newPos = ccpAdd(soldierSelectedForDrag.sprite.position, translation);
        soldierSelectedForDrag.sprite.position = newPos;
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    if ([touches count] == 2 && selectedSoldier) {
        NSArray *twoTouches = [touches allObjects];
        UITouch *first = [twoTouches objectAtIndex:0];
        UITouch *second = [twoTouches objectAtIndex:1];
        
        CGFloat currentAngle = [Helper angleBetweenLineStarting:[first previousLocationInView:[first view]] ending:[second previousLocationInView:[second view]] andLineStarting:[first locationInView:[first view]] andEnding:[second locationInView:[second view]]];
        selectedSoldier.direction = selectedSoldier.direction + currentAngle;
        [selectedSoldier.sprite setRotation:CC_RADIANS_TO_DEGREES(selectedSoldier.direction)];
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    if(addingNewSoldier){
        [world.soldiers addObject: soldierSelectedForDrag];
        addingNewSoldier = NO;
    }
    soldierSelectedForDrag = Nil;
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    for (Soldier *soldier in world.soldiers) {
        if(CGRectContainsPoint([soldier.sprite boundingBox], [self convertTouchToNodeSpace:touch])){
            soldierSelectedForDrag = soldier;
            selectedSoldier = soldier;
            break;
        }
            
    }
    return YES;
}

@end
