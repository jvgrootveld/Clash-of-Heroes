//
//  Priest.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Priest.h"

@implementation Priest

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag
{
    if (self == [super initWithName:@"Priest" 
                             player:player
    andBaseStatsPhysicalAttackPower:10
                 magicalAttackPower:0
                    physicalDefense:10
                     magicalDefense:7
                       healthPoints:40
                              range:3
                           movement:3]
        )
    {
        [self setSpriteTag:tag];
    }
    
    return self;
}

@end
