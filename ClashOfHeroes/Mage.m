//
//  Mage.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Mage.h"

@implementation Mage

#define spriteLocation CGRectMake(215, 482, 26, 52)

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag
{
    if (self == [super initWithName:@"Mage" 
                             player:player
    andBaseStatsPhysicalAttackPower:0
                 magicalAttackPower:10
                    physicalDefense:5
                     magicalDefense:5
                       healthPoints:30
                              range:3
                           movement:3
                                tag:tag
                               file:@"sprites.png" 
                               rect:spriteLocation]
        )
    {
        [self setMoveDirection: FORWARD | LEFT | RIGHT];
        [self setAttackDirection: FORWARD | LEFT | RIGHT];
    }
    
    return self;
}

@end
