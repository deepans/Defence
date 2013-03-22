//
//  QTNode.h
//  Defence
//
//  Created by Deepan Subramani on 08/03/13.
//
//

#import <Foundation/Foundation.h>
#import "QTIntermediateNode.h"
#import "QTLeafNode.h"

@class QTIntermediateNode;
@class QTLeafNode;

@protocol QTNode <NSObject>
-(void) addObject:(id<QuadTreeable>) object;
-(QTLeafNode *) getNode:(id<QuadTreeable>) object;
-(void) removeObject:(id<QuadTreeable>) object;
@end
