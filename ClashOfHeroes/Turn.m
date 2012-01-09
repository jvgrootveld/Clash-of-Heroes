//
//  Turn.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "Turn.h"

@implementation Turn

@synthesize movements = _movements, actions = _actions;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.movements forKey:@"movements"];
    [aCoder encodeObject:self.actions forKey:@"actions"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.movements = [aDecoder decodeObjectForKey:@"movements"];
        self.actions = [aDecoder decodeObjectForKey:@"actions"];
    }
    
    return self;
}

@end
