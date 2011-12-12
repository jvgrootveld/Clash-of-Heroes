//
//  Mage.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Mage.h"

@implementation Mage

- (id)initForPlayer:(GKPlayer *)player
{
    if (self == [super initWithName:@"Mage" 
                             player:player
    andBaseStatsPhysicalAttackPower:0
                 magicalAttackPower:10
                    physicalDefense:5
                     magicalDefense:5
                       healthPoints:30
                              range:3
                           movement:3]
        )
    {
        //Customize unit
    }
    
    return self;
}

@end
