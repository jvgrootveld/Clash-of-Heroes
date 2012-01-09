//
//  WarriorUnitFactory.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/9/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "WarriorUnitFactory.h"
#import "Unit.h"

@implementation WarriorUnitFactory

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
    
//    [piece setCode:code];
//    
//    //gear
//    Gear *gear = [Crown new];
//    
//    gear = [[Breastplate alloc] initWithGear:gear];
//    gear = [[Legplates alloc] initWithGear:gear];
//    gear = [[Gaunlets alloc] initWithGear:gear];
//    gear = [[Greaves alloc] initWithGear:gear];
//    gear = [[Sword alloc] initWithGear:gear];
//    
//    [piece setGear:gear];
    
    return unit;
}

@end
