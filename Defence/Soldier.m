//
//  Soldier.m
//  Defence
//
//  Created by Deepan Subramani on 10/02/13.
//
//

#import "Soldier.h"

@implementation Soldier
@synthesize direction, sprite, shootingDelay, shootingPower, zombiesInRange;

-(id) initWithSprite: (CCSprite *) _sprite{
    if((self = [super init])){
        sprite = _sprite;
        direction = 0;
        zombiesInRange = [[NSMutableArray alloc] init];
    }
    return self;
}


-(CGRect) getBoundry{
    return sprite.boundingBox;
}

@end
