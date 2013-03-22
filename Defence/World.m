//
//  World.m
//  Defence
//
//  Created by Deepan Subramani on 08/03/13.
//
//

#import "World.h"
#import "QTIntermediateNode.h"
#import "QuadTreeable.h"
#import "Helper.h"

@implementation World

@synthesize soldiers, zombies;

-(id) init{
    if(self = [super init]){
        soldiers = [[NSMutableArray alloc] init];
        zombies = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void) update:(ccTime)delta{
    [self talkSnap];
    for (int i = 0; i < soldiers.count; i++) {
        Soldier *soldier = soldiers[i];
        for (int j = 0; j < soldier.zombiesInRange.count; j++) {
            Zombie *zombie = soldier.zombiesInRange[j];
            [zombie die];
            [zombies removeObject:zombie];
        }
    }
}


-(void) talkSnap{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    QTIntermediateNode *rootNode = [[QTIntermediateNode alloc] initRootNodeWithBoundry:CGRectMake(0, 0, winSize.width, winSize.height)];
    for (int i = 0; i < soldiers.count; i++) {
        [rootNode addObject:soldiers[i]];
    }
    for (int i = 0; i < zombies.count; i++) {
        [rootNode addObject:zombies[i]];
    }
    
    [self snapSoldiers: rootNode];
    [self snapSoldiers: rootNode];
}

-(void) snapSoldiers:(QTIntermediateNode *) rootNode{
    for (int i = 0; i < soldiers.count; i++) {
        Soldier *soldier = soldiers[i];
        [soldier.zombiesInRange removeAllObjects];

        QTLeafNode *leafNode = [rootNode getNode:soldier];
        NSMutableArray *zombiesAndSoldiersInRange = leafNode.objects;
        for (int j = 0; j < zombiesAndSoldiersInRange.count; j++) {
            if([zombiesAndSoldiersInRange[j] class] == [Zombie class] && CGRectIntersectsRect([soldier getBoundry], [zombiesAndSoldiersInRange[j] getBoundry])) {
                NSLog(@"%@ === %@", NSStringFromCGRect([soldier getBoundry]), NSStringFromCGRect([zombiesAndSoldiersInRange[j] getBoundry]));
                Zombie *zombieInRange = zombiesAndSoldiersInRange[j];
                [soldier.zombiesInRange addObject:zombieInRange];
            }
        }
        
    }
}

-(void) snapZombies:(QTIntermediateNode *) rootNode{
    for (int i = 0; i < zombies.count; i++) {
        Zombie *zombie = zombies[i];
        [zombie.soldiersInRange removeAllObjects];
        
        NSMutableArray *zombiesAndSoldiersInRange = [rootNode getNode:zombie].objects;
        for (int j = 0; j < zombiesAndSoldiersInRange.count; j++) {
            if([zombiesAndSoldiersInRange[j] class] == [Soldier class] && CGRectIntersectsRect([zombie getBoundry], [zombiesAndSoldiersInRange[j] getBoundry])){

                Soldier *soldierInRange = zombiesAndSoldiersInRange[j];
                [zombie.soldiersInRange addObject:soldierInRange];
            }
        }
        
    }
}







@end
