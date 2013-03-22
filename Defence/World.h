//
//  World.h
//  Defence
//
//  Created by Deepan Subramani on 08/03/13.
//
//

#import <Foundation/Foundation.h>
#import "Soldier.h"
#import "Zombie.h"

@interface World : NSObject{
@private
    NSMutableArray *soldiers;
    NSMutableArray *zombies;
}

@property (nonatomic, strong, readonly) NSMutableArray *soldiers;
@property (nonatomic, strong, readonly) NSMutableArray *zombies;

-(void) talkSnap;
-(void) update:(ccTime)delta;
@end
