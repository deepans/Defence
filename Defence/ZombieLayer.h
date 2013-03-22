//
//  ZombieLayer.h
//  Defence
//
//  Created by Deepan Subramani on 12/02/13.
//
//

#import "CCNode.h"
#import "World.h"

@class World, Zombie;

@interface ZombieLayer : CCNode{
    @private
    World *world;
}
@property (nonatomic, strong) World *world;

-(void) addZombieToWalkAlongPath:(NSArray *) path atASpeed:(NSInteger) speed;
@end
