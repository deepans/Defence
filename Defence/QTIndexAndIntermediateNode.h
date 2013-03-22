//
//  IndexAndLeftNode.h
//  Defence
//
//  Created by Deepan Subramani on 07/03/13.
//
//

#import <Foundation/Foundation.h>
#import "QTIntermediateNode.h"

@interface QTIndexAndIntermediateNode : NSObject{
    @private
    int index;
    QTIntermediateNode *intermediateNode;
}

@property (nonatomic, strong) QTIntermediateNode *intermediateNode;
@property (nonatomic) int index;
-(id) initWithIndex:(int) _index andIntermediateNode:(QTIntermediateNode *) _intermediateNode;
@end
