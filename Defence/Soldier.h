//
//  Soldier.h
//  Defence
//
//  Created by Deepan Subramani on 10/02/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "QuadTreeable.h"

@interface Soldier : NSObject<QuadTreeable>{
    @private
    float direction;
    CCSprite *sprite;
    int shootingDelay;
    float shootingPower;
    NSMutableArray *zombiesInRange;
}

@property (nonatomic) int shootingDelay;
@property (nonatomic) float shootingPower;
@property (nonatomic) float direction;
@property (nonatomic, strong, readonly) CCSprite *sprite;
@property (nonatomic, strong, readonly) NSMutableArray *zombiesInRange;

-(id) initWithSprite: (CCSprite *) _sprite;

@end
