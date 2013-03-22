//
//  QTNode.m
//  Defence
//
//  Created by Deepan Subramani on 07/03/13.
//
//

#import "QTIntermediateNode.h"
#import "QTLeafNode.h"
#import "QTIndexAndIntermediateNode.h"
#import "QTNode.h"

@implementation QTIntermediateNode
@synthesize nodes, boundry, depth;

-(id) initRootNodeWithBoundry:(CGRect) _boundry{
    [self initWithBoundry:_boundry];
    depth = 1;
    [self split];
    return self;
}

-(id) initWithBoundry:(CGRect) _boundry{
    if(self = [super init]){
        nodes = [NSMutableArray array];
        boundry = _boundry;
    }
    return self;
}

-(void) addObject:(id<QuadTreeable>) object{
    QTLeafNode *leafNode = [self getNode:object];
    [leafNode addObject:object];
}

-(BOOL) replaceLeafNode:(QTLeafNode*) leafNode withIntermediateNode:(QTIntermediateNode *) intermediateNode{
    for (int i = 0; i < nodes.count; i++) {
        if(nodes[i] == leafNode){
            nodes[i] = intermediateNode;
            intermediateNode.depth = depth + 1;
            return YES;
        }
    }
    return NO;
}

-(void) split{
    float childHeight = boundry.size.height / 2;
    float childWidth = boundry.size.width / 2;
    
    [nodes addObject:[[QTLeafNode alloc] initWithBoundry:CGRectMake(boundry.origin.x, boundry.origin.y, childWidth, childHeight) asChildOf:self]];
    [nodes addObject:[[QTLeafNode alloc] initWithBoundry:CGRectMake(boundry.origin.x + childWidth, boundry.origin.y + childHeight, childWidth, childHeight) asChildOf:self]];
    [nodes addObject:[[QTLeafNode alloc] initWithBoundry:CGRectMake(boundry.origin.x + childWidth, boundry.origin.y, childWidth, childHeight) asChildOf:self]];
    [nodes addObject:[[QTLeafNode alloc] initWithBoundry:CGRectMake(boundry.origin.x, boundry.origin.y + childHeight, childWidth, childHeight) asChildOf:self]];
}


-(void) removeObject:(id<QuadTreeable>) object{
    QTLeafNode *leafNode = [self getNode:object];
    [leafNode removeObject:object];
}

-(QTLeafNode *) getNode:(id<QuadTreeable>) object{
    CGRect objectBoundry = [object getBoundry];
    if(CGRectIntersectsRect(objectBoundry, boundry)){
        for (int i = 0; i < nodes.count; i++) {
            QTLeafNode *leafNode = [nodes[i] getNode:object];
            if(leafNode)
                return leafNode;
        }
    }
    return nil;
}

@end
