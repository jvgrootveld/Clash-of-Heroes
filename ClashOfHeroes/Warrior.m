//
//  Warrior.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import "Warrior.h"

@implementation Warrior

#define spriteLocationSelf CGRectMake(13, 472, 26, 62)
#define spriteLocationEnemy CGRectMake(172, 833, 25, 62)

- (id)initForPlayer:(Player *)player withTag:(NSInteger)tag
{   
    CGRect spriteLocation = spriteLocationEnemy;
    
    //if unit is for local player
    if([[[GCTurnBasedMatchHelper sharedInstance] playerForLocalPlayer].gameCenterInfo.playerID isEqualToString:player.gameCenterInfo.playerID])
    {
        spriteLocation = spriteLocationSelf;
    }
    
    if (self == [super initWithName:@"Warrior" 
                             player:player
    andBaseStatsPhysicalAttackPower:20
                 magicalAttackPower:0
                    physicalDefense:10
                     magicalDefense:7
                       healthPoints:100
                              range:3
                           movement:10
                                tag:tag
                               file:@"sprites.png"
                               rect:spriteLocation]
        )
    {
        [self setMoveDirection: FORWARD | LEFT | RIGHT | FORWARDLEFT | FORWARDRIGHT];
        [self setAttackDirection: FORWARD | LEFT | RIGHT | FORWARDLEFT | FORWARDRIGHT];
    }
    
    return self;
}

@end
