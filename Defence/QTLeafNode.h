//
//  QTLeafNode.h
//  Defence
//
//  Created by Deepan Subramani on 07/03/13.
//
//

#import <Foundation/Foundation.h>
#import "QuadTreeable.h"
#import "QTIntermediateNode.h"
#import "QTNode.h"

@class QTIntermediateNode;

@interface QTLeafNode : NSObject<QTNode>{
    @private
    NSMutableArray *objects;
    CGRect boundry;
    QTIntermediateNode *parent;
}

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) QTIntermediateNode *parent;
@property (nonatomic) CGRect boundry;
-(id) initWithBoundry:(CGRect) _boundry asChildOf:(QTIntermediateNode *) _parent;
@end
