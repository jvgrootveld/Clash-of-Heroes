//
//  Match.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "Match.h"
#import "Player.h"

@implementation Match

@synthesize players = _players;

- (id)init
{
    if (self = [super init])
    {
        _players = [NSMutableArray arrayWithCapacity:2];
    }
    
    return self;
}

- (void)addPlayer:(Player *)player
{
    if (!(self.players.count >= 2))
    {        
        [self.players addObject:player];
    }
}

@end
