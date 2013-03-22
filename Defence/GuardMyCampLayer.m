#import "GuardMyCampLayer.h"

#import "AppDelegate.h"
#import "MyCampBackgroundLayer.h"
#import "SoldiersLayer.h"
#import "ZombieLayer.h"
#import "ControlPanelLayer.h"
#import "World.h"
#import "Helper.h"

#pragma mark - HelloWorldLayer

@implementation GuardMyCampLayer

+(CCScene *) scene
{
    World *world = [[World alloc] init];
	CCScene *scene = [CCScene node];
	GuardMyCampLayer *sceneLayer = [GuardMyCampLayer node];
    MyCampBackgroundLayer *backgroundLayer = [MyCampBackgroundLayer node];
    SoldiersLayer *soldiersLayer = [SoldiersLayer node];
    soldiersLayer.world = world;
    ZombieLayer *zombieLayer = [ZombieLayer node];
    zombieLayer.world = world;
    ControlPanelLayer *controlPanelLayer = [ControlPanelLayer node];
    
    controlPanelLayer.delegate = soldiersLayer;
    
    [sceneLayer addChild:backgroundLayer];
    [sceneLayer addChild:controlPanelLayer];
    [sceneLayer addChild:soldiersLayer];
    [sceneLayer addChild:zombieLayer];

    
	[scene addChild: sceneLayer];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    NSArray *path = [Helper generatePathForZombieToWalkFrom:CGPointMake(20, 20) to:CGPointMake(winSize.width - 20, winSize.height - 20)];
    NSArray *path1 = [Helper generatePathForZombieToWalkFrom:CGPointMake(winSize.width - 70, winSize.height - 80) to:CGPointMake(30, 20)];
    [zombieLayer addZombieToWalkAlongPath:path atASpeed:40];
    [zombieLayer addZombieToWalkAlongPath:path1 atASpeed:80];
    

	return scene;
}

- (void) dealloc
{
	[super dealloc];
}

@end