//
//  NoUpgrade.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "NoUpgrade.h"

@implementation NoUpgrade

- (id)init
{
    self = [super init];
    if (self) 
    {
        _name = @"No upgrade";
    }
    
    return self;
}

- (NSString *)description
{
    return [super description];
}

@end
