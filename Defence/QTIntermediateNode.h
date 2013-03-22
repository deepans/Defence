//
//  QTNode.h
//  Defence
//
//  Created by Deepan Subramani on 07/03/13.
//
//

#import <Foundation/Foundation.h>
#import "QTLeafNode.h"
#import "QuadTreeable.h"
#import "QTNode.h"

@class QTLeafNode;

@interface QTIntermediateNode : NSObject<QTNode>{
    @private
    NSMutableArray *nodes;
    CGRect boundry;
    int depth;
}

@property (nonatomic, strong, readonly) NSMutableArray *nodes;
@property (nonatomic, readonly) CGRect boundry;
@property (nonatomic) int depth;

-(void) split;
-(id) initWithBoundry:(CGRect) _boundry;
-(id) initRootNodeWithBoundry:(CGRect) _boundry;
-(BOOL) replaceLeafNode:(QTLeafNode*) leafNode withIntermediateNode:(QTIntermediateNode *) intermediateNode;
@end
