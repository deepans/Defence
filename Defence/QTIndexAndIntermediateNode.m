//
//  IndexAndLeftNode.m
//  Defence
//
//  Created by Deepan Subramani on 07/03/13.
//
//

#import "QTIndexAndIntermediateNode.h"

@implementation QTIndexAndIntermediateNode
@synthesize index, intermediateNode;

-(id) initWithIndex:(int) _index andIntermediateNode:(QTIntermediateNode *) _intermediateNode{
    if(self = [super init]){
        index = _index;
        intermediateNode = _intermediateNode;
    }
    return self;
}
@end
