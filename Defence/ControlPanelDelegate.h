//
//  ControlPanelDelegate.h
//  Defence
//
//  Created by Deepan Subramani on 18/01/13.
//
//

#import <Foundation/Foundation.h>

@protocol ControlPanelDelegate <NSObject>
@required
-(void) addNewSoldier: (CGPoint) origin;
@end
