//
//  Ranger.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Ranger.h"

@implementation Ranger

#define spriteLocation CGRectMake(10, 10, 26, 62)

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag
{
    if (self == [super initWithName:@"Ranger" 
                             player:player
    andBaseStatsPhysicalAttackPower:8
                 magicalAttackPower:3
                    physicalDefense:8
                     magicalDefense:3
                       healthPoints:35
                              range:3
                           movement:3
                                tag:tag
                               file:@"sprites.png" 
                               rect:spriteLocation]
        )
    {

    }
    
    return self;
}

@end
