//
//  Zombie.m
//  Defence
//
//  Created by Deepan Subramani on 16/02/13.
//
//

#import "Zombie.h"
#import "Helper.h"

@implementation Zombie{
    float speed;
}

@synthesize direction, sprite, pathToWalk, walkAction, health, soldiersInRange;

-(id) initAtPosition: (CGPoint) position{
    if((self = [super init])){
        self.walkAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:[self walkAnimation]]];
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"00004a.png"];
        self.sprite.position = ccp(position.x, position.y);
        self.direction = 0;
        self.soldiersInRange = [[NSMutableArray alloc] init];
    }
    return self;
}

-(CCAnimation *) walkAnimation{
    static dispatch_once_t pred;
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    dispatch_once(&pred, ^{
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"Zombiea.plist"];
    });
    for(int i = 5; i <= 12; ++i) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"000%02da.png", i]]];
    }
    return [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.1f];
}

-(void) walkOnPath:(NSArray *) path atASpeed: (float) _speed{
    speed = _speed;
    if(path.count > 0){
        [self.sprite runAction:walkAction];
        self.pathToWalk = [NSMutableArray arrayWithArray:path];
        [self turn];
//        [self hop];
    }
}

-(void) hop{
    CGPoint currentPosition = self.sprite.position;
    CGPoint targetLocation = [[self.pathToWalk objectAtIndex:0] CGPointValue];
    float time = [Helper distanceBetweenPoint:currentPosition andPoint:targetLocation] / speed;
    
    CCAction *moveAction = [CCSequence actions:[CCMoveTo actionWithDuration:time position:targetLocation], [CCCallFuncND actionWithTarget:self selector:@selector(hopReached:data:) data:self], nil];
    [sprite runAction:moveAction];
}

-(void) turn{
    CGPoint currentPosition = self.sprite.position;
    CGPoint targetPosition = [[self.pathToWalk objectAtIndex:0] CGPointValue];
    
    float angle = [Helper angleBetweenPoint:currentPosition andPoint:targetPosition];
    
    float angleWRTPreviousPosition = angle - self.direction;
    float angleWRTPreviousPositionInOtherDirection = 360 - fabsf(angleWRTPreviousPosition);
    
    float angleToRorate = fabsf(angleWRTPreviousPosition) <= 360 - fabsf(angleWRTPreviousPosition) ? angleWRTPreviousPosition : angleWRTPreviousPosition < 0 ? angleWRTPreviousPositionInOtherDirection : - angleWRTPreviousPositionInOtherDirection;
    
    CCAction *turnAction = [CCSequence actions:[CCRotateBy actionWithDuration:.1 angle:angleToRorate], [CCCallFuncND actionWithTarget:self selector:@selector(turned:data:) data:self], nil];

    self.direction = angle;
    
    [self.sprite runAction: turnAction];
}

-(void) turned: (id)sender data:(Zombie *) zombie{
    [zombie hop];
}

-(void) hopReached: (id)sender data:(Zombie *) zombie{
    [zombie.pathToWalk removeObjectAtIndex:0];
    if(zombie.pathToWalk.count > 0)
        [zombie turn];
    else{
        [zombie.sprite stopAction:zombie.walkAction];
    }
}

-(CGRect) getBoundry{
    return CGRectMake(sprite.boundingBox.origin.x + 6, sprite.boundingBox.origin.y + 41, 41, 22);
}

-(void) die{
    [self.sprite removeFromParentAndCleanup:YES];
}

@end
