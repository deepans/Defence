//
//  Zombie.h
//  Defence
//
//  Created by Deepan Subramani on 16/02/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "QuadTreeable.h"
#import "ZombieLayer.h"

@class ZombieLayer;

@interface Zombie : NSObject<QuadTreeable>{
    @private
    float direction;
    CCSprite *sprite;
    NSMutableArray *pathToWalk;
    CCAction *walkAction;
    float health;
    NSMutableArray *soldiersInRange;
}

@property (nonatomic, strong) CCSprite *sprite;
@property (nonatomic) float direction;
@property (nonatomic, strong) NSMutableArray *pathToWalk;
@property (nonatomic, strong) CCAction *walkAction;
@property (nonatomic) float health;
@property (nonatomic, strong) NSMutableArray *soldiersInRange;

-(id) initAtPosition: (CGPoint) position;
-(void) walkOnPath:(NSArray *) path atASpeed: (float) speed;
-(void) hop;
-(void) turn;
-(void) die;

@end
