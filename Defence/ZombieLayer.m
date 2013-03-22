//
//  ZombieLayer.m
//  Defence
//
//  Created by Deepan Subramani on 12/02/13.
//
//

#import "ZombieLayer.h"
#import "cocos2d.h"
#import "Zombie.h"
#import "Helper.h"

@implementation ZombieLayer{
    NSMutableArray *walkAnimFrames;
    CCAction *walkAction;
    CCAction *moveAction;
    CCAnimation *walkAnim;
    CCSpriteBatchNode *spriteSheet;
}

@synthesize world;

-(id) init {
    if((self=[super init])) {
        spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Zombiea.png"];
        [self addChild:spriteSheet];

        [self schedule:@selector(step:) interval:1.0/60.0];
    }
    return self;
}

-(void) step:(ccTime)delta
{
    [self.world update:delta];
}

-(void) addZombieToWalkAlongPath:(NSArray *) path atASpeed:(NSInteger) speed{
    Zombie *zombie = [[Zombie alloc] initAtPosition:[[path objectAtIndex:0] CGPointValue]] ;
    [world.zombies addObject:zombie];
    
    [spriteSheet addChild:zombie.sprite z:0];
    [zombie walkOnPath:[path subarrayWithRange:NSMakeRange(1, path.count - 1)] atASpeed:speed];
}

@end
