//
//  Ranger.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Ranger.h"

@implementation Ranger

#define spriteLocationSelf CGRectMake(423, 755, 26, 62)
#define spriteLocationEnemy CGRectMake(421, 563, 25, 57)

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag
{
    CGRect spriteLocation = spriteLocationEnemy;
    
    //if unit is for local player
    if([[[GCTurnBasedMatchHelper sharedInstance] playerForLocalPlayer].gameCenterInfo.playerID isEqualToString:player.gameCenterInfo.playerID])
    {
        spriteLocation = spriteLocationSelf;
    }
    
    if (self == [super initWithName:@"Ranger" 
                             player:player
    andBaseStatsPhysicalAttackPower:10
                 magicalAttackPower:10
                    physicalDefense:8
                     magicalDefense:3
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
