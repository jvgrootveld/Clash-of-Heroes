//
//  Unit.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Upgrade;
@class Player;
@class GameLayer;

typedef enum
{
    FORWARD = 1,
    BACKWARD = 2,
    LEFT = 4,
    RIGHT = 8,
    FORWARDLEFT = 16,
    FORWARDRIGHT = 32,
    BACKWARDLEFT = 64,
    BACKWARDRIGHT = 128
}Direction;

@interface Unit : CCSprite
{
    Player *_player;
    
@protected
    Upgrade *_upgrade;
    NSInteger _basePhysicalAttackPower;
    NSInteger _baseMagicalAttackPower;
    NSInteger _basePhysicalDefense;
    NSInteger _baseMagicalDefense;
    NSInteger _baseHealthPoints;
    NSInteger _baseRange;
    NSInteger _baseMovement;
    NSString *_code;
    Direction _moveDirection;
    Direction _attackDirection;
    NSInteger _recievedDamage;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) Player *player;
@property (nonatomic, retain) Upgrade *upgrade;
@property (nonatomic, assign) Direction moveDirection;
@property (nonatomic, assign) Direction attackDirection;
@property (nonatomic) BOOL canAttackTroughAir;
@property (nonatomic) CGPoint location; //not in pixels 

- (id)initWithName:(NSString *)name player:(Player *)player andBaseStatsPhysicalAttackPower:(NSInteger)physicalAttackPower magicalAttackPower:(NSInteger)magicalAttackPower physicalDefense:(NSInteger)physicalDefense magicalDefense:(NSInteger)magicalDefense healthPoints:(NSInteger)healthPoints range:(NSInteger)range movement:(NSInteger)movement tag:(NSInteger)tag file:(NSString*)filename rect:(CGRect)rect;
- (NSInteger)physicalAttackPower;
- (NSInteger)magicalAttackPower;
- (NSInteger)physicalDefense;
- (NSInteger)magicalDefense;
- (NSInteger)healthPoints;
- (NSInteger)range;
- (NSInteger)movement;

- (BOOL)belongsToPlayer:(Player *)player;
- (BOOL)containsDirection:(Direction)direction InDirection:(Direction)directionList;
- (BOOL)canMoveInDirection:(Direction)direction;
- (BOOL)canAttackInDirection:(Direction)direction;
- (NSMutableArray *)pointsWhichCanBeMovedAtWithTouchPositionPoint:(CGPoint)positionPoint inLayer:(GameLayer *)layer;

- (BOOL)recieveDamage:(NSInteger)damage;
- (void)reduceDamage:(NSInteger)damage;

//for printing
- (void)setCode:(NSString *)code;
- (NSString *)printCode;

@end
