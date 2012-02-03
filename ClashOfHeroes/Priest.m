//
//  Priest.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Priest.h"

@implementation Priest

#define spriteLocationSelf CGRectMake(14, 756, 26, 62)
#define spriteLocationEnemy CGRectMake(12, 562, 24, 58)

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag
{
    CGRect spriteLocation = spriteLocationEnemy;
    
    //if unit is for local player
    if([[[GCTurnBasedMatchHelper sharedInstance] playerForLocalPlayer].gameCenterInfo.playerID isEqualToString:player.gameCenterInfo.playerID])
    {
        spriteLocation = spriteLocationSelf;
    }
    
    if (self == [super initWithName:@"Priest" 
                             player:player
    andBaseStatsPhysicalAttackPower:10
                 magicalAttackPower:0
                    physicalDefense:4
                     magicalDefense:7
                       healthPoints:100
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
