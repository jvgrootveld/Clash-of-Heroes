//
//  Shapeshifter.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Shapeshifter.h"

@implementation Shapeshifter

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag
{
    if (self == [super initWithName:@"Shapeshifter" 
                             player:player
    andBaseStatsPhysicalAttackPower:3
                 magicalAttackPower:3
                    physicalDefense:3
                     magicalDefense:3
                       healthPoints:25
                              range:3
                           movement:3]
        )
    {
        [self setSpriteTag:tag];
    }
    
    return self;
}

@end
