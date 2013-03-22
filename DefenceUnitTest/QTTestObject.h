//
//  QTTestObject.h
//  Defence
//
//  Created by Deepan Subramani on 08/03/13.
//
//

#import <Foundation/Foundation.h>
#import "QuadTreeable.h"

@interface QTTestObject : NSObject<QuadTreeable>
-(id) initWithBoundry:(CGRect ) _boundry;
@end
