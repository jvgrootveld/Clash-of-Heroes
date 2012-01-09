//
//  ShapeshifterUnitFactory.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/9/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "ShapeshifterUnitFactory.h"
#import "Unit.h"

@implementation ShapeshifterUnitFactory

+ (Unit *)createUnitWithTag:(NSInteger)tag forPlayer:(Player *)player;
{
    //basic piece
    Unit *unit = [[Unit alloc] initWithName:@"Warrior" 
                                     player:player 
            andBaseStatsPhysicalAttackPower:20 
                         magicalAttackPower:0 
                            physicalDefense:20 
                             magicalDefense:20 
                               healthPoints:100 
                                      range:3 
                                   movement:2];
    
    [unit setMoveDirection: TOP | LEFT | RIGHT];
    [unit setAttackDirection: TOP | LEFT | RIGHT];
    
    return unit;
}

@end
