//
//  ColorHelper.m
//  Defence
//
//  Created by Deepan Subramani on 16/01/13.
//
//

#import "ColorHelper.h"

@implementation ColorHelper

+(ccColor4F) parrot{
    return ccc4FFromccc4B(ccc4(98 % 255, 233 % 255, 182 % 255, 255));
}

+(ccColor4F) sand{
        return ccc4FFromccc4B(ccc4(218 % 255, 165 % 255, 91 % 255, 255));
}

+(ccColor4F) grass{
    return ccc4FFromccc4B(ccc4(42 % 255, 236 % 255, 97 % 255, 255));
}
@end
