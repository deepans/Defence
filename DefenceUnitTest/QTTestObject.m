//
//  QTTestObject.m
//  Defence
//
//  Created by Deepan Subramani on 08/03/13.
//
//

#import "QTTestObject.h"

@implementation QTTestObject{
    CGRect boundry;
}

-(id) initWithBoundry:(CGRect ) _boundry{
    if(self = [super init]){
        boundry = _boundry;
    }
    return self;
}

-(CGRect) getBoundry{
    return boundry;
}


@end
