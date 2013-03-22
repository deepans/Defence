//
//  ControlPanelLayer.h
//  Defence
//
//  Created by Deepan Subramani on 18/01/13.
//
//

#import "CCLayer.h"
#import "ControlPanelDelegate.h"

@interface ControlPanelLayer : CCLayer{
    @private
    __weak id<ControlPanelDelegate> delegate;
}

@property (nonatomic, weak) id<ControlPanelDelegate> delegate;

@end
