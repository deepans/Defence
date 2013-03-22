//
//  QTIntermediateNodeTest.m
//  Defence
//
//  Created by Deepan Subramani on 07/03/13.
//
//

#import "QTIntermediateNodeTest.h"
#import "QTIntermediateNode.h"
#import "QTLeafNode.h"
#import "Constants.h"
#import "QTTestObject.h"

@implementation QTIntermediateNodeTest
- (void)testShouldSplit
{
    QTIntermediateNode *rootNode = [[QTIntermediateNode alloc] initRootNodeWithBoundry:CGRectMake(1, 1, 100, 50)];

    STAssertEquals(rootNode.nodes.count, (NSUInteger)4, nil);

    STAssertEquals([(QTLeafNode *)rootNode.nodes[0] boundry], CGRectMake(1, 1, 50, 25), nil);
    STAssertEquals([(QTLeafNode *)rootNode.nodes[1] boundry], CGRectMake(51, 26, 50, 25), nil);
    STAssertEquals([(QTLeafNode *)rootNode.nodes[2] boundry], CGRectMake(51, 1, 50, 25), nil);
    STAssertEquals([(QTLeafNode *)rootNode.nodes[3] boundry], CGRectMake(1, 26, 50, 25), nil);
}

-(void) testShouldInsertObject{
    QTIntermediateNode *rootNode = [[QTIntermediateNode alloc] initRootNodeWithBoundry:CGRectMake(1, 1, 100, 100)];
    
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(5, 5, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(95, 95, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(5, 95, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(95, 5, 5, 5)]];
    
    STAssertEquals((NSUInteger)1, [(QTLeafNode*)[rootNode nodes][0] objects].count , nil);
    STAssertEquals((NSUInteger)1, [(QTLeafNode*)[rootNode nodes][1] objects].count , nil);
    STAssertEquals((NSUInteger)1, [(QTLeafNode*)[rootNode nodes][2] objects].count , nil);
    STAssertEquals((NSUInteger)1, [(QTLeafNode*)[rootNode nodes][3] objects].count , nil);
    
    // add 3 more in the last quadrant

    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(60, 5, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(60, 5, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(60, 5, 5, 5)]];
    
    STAssertEquals((NSUInteger)1, [(QTLeafNode*)[rootNode nodes][0] objects].count , nil);
    STAssertEquals((NSUInteger)1, [(QTLeafNode*)[rootNode nodes][1] objects].count , nil);
    STAssertEquals((NSUInteger)4, [(QTIntermediateNode*)[rootNode nodes][2] nodes].count , nil);
    STAssertEquals((NSUInteger)1, [(QTLeafNode*)[rootNode nodes][3] objects].count , nil);
    
    STAssertEquals((NSUInteger)3, [(QTLeafNode *)[(QTIntermediateNode*)[rootNode nodes][2] nodes][0] objects].count , nil);
    STAssertEquals((NSUInteger)0, [(QTLeafNode *)[(QTIntermediateNode*)[rootNode nodes][2] nodes][1] objects].count , nil);
    STAssertEquals((NSUInteger)1, [(QTLeafNode *)[(QTIntermediateNode*)[rootNode nodes][2] nodes][2] objects].count , nil);
    STAssertEquals((NSUInteger)0, [(QTLeafNode *)[(QTIntermediateNode*)[rootNode nodes][2] nodes][3] objects].count , nil);
}

-(void) testShouldRemoveObject{
    QTIntermediateNode *rootNode = [[QTIntermediateNode alloc] initRootNodeWithBoundry:CGRectMake(1, 1, 100, 100)];
    
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(5, 5, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(95, 95, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(5, 95, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(95, 5, 5, 5)]];

    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(60, 5, 5, 5)]];
    [rootNode addObject:[[QTTestObject alloc] initWithBoundry:CGRectMake(60, 5, 5, 5)]];
    QTTestObject *testObject = [[QTTestObject alloc] initWithBoundry:CGRectMake(60, 5, 5, 5)];
    [rootNode addObject:testObject];

    STAssertEquals((NSUInteger)3, [(QTLeafNode *)[(QTIntermediateNode*)[rootNode nodes][2] nodes][0] objects].count , nil);
    [rootNode removeObject:testObject];
    STAssertEquals((NSUInteger)2, [(QTLeafNode *)[(QTIntermediateNode*)[rootNode nodes][2] nodes][0] objects].count , nil);
}

@end
