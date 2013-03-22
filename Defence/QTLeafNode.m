//
//  QTLeafNode.m
//  Defence
//
//  Created by Deepan Subramani on 07/03/13.
//
//

#import "QTLeafNode.h"
#import "Constants.h"
#import "QTIntermediateNode.h"

@implementation QTLeafNode
@synthesize objects, boundry, parent;

-(id) initWithBoundry:(CGRect) _boundry asChildOf:(QTIntermediateNode *) _parent{
    if(self = [super init]){
        boundry = _boundry;
        objects = [NSMutableArray array];
        parent = _parent;
    }
    return self;
}

-(void) addObject:(id<QuadTreeable>) object{
    if(objects.count == MAX_ALLOWED_OBJECTS_IN_NODE && parent.depth <= MAX_ALLOWED_DEPTH){
        QTIntermediateNode *node = [[QTIntermediateNode alloc] initWithBoundry:boundry];
        [node split];
        for (int i = 0; i < objects.count; i++) {
            [node addObject:objects[i]];
        }
        [node addObject:object];
        [parent replaceLeafNode:self withIntermediateNode:node];
    }else{
        [objects addObject:object];
    }
}

-(QTLeafNode *) getNode:(id<QuadTreeable>) object{
    return CGRectIntersectsRect([object getBoundry], boundry) ? self: nil;
}

-(void) removeObject:(id<QuadTreeable>) object{
    [objects removeObject:object];
}

@end
