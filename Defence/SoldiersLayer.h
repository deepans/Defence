//
//  SoldiersLayer.h
//  Defence
//
//  Created by Deepan Subramani on 17/01/13.
//
//

#import "CCLayer.h"
#import "ControlPanelDelegate.h"
#import "World.h"

@interface SoldiersLayer : CCLayer<ControlPanelDelegate>{
    @private
    World *world;
}

@property (nonatomic, strong) World *world;

@end
