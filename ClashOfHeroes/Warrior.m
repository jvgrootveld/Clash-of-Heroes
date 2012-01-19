//
//  Warrior.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Warrior.h"

@implementation Warrior

#define spriteLocation CGRectMake(13, 472, 26, 62)

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag
{
    if (self == [super initWithName:@"Warrior" 
                             player:player
    andBaseStatsPhysicalAttackPower:7
                 magicalAttackPower:0
                    physicalDefense:10
                     magicalDefense:7
                       healthPoints:40
                              range:3
                           movement:3
                                tag:tag
                               file:@"sprites.png" 
                               rect:spriteLocation]
        )
    {
        [self setMoveDirection: FORWARD | LEFT | RIGHT | FORWARDLEFT | FORWARDRIGHT];
        [self setAttackDirection: FORWARD | LEFT | RIGHT];
    }
    
    return self;
}

@end
