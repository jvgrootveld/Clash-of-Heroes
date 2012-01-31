//
//  Player.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GKPlayer;
@class Unit;
@class Hero;

@interface Player : NSObject

@property (nonatomic, strong) GKPlayer *gameCenterInfo;
@property (nonatomic, strong) Hero *hero;
@property (nonatomic, strong) NSMutableArray *units;
@property (nonatomic, strong) NSArray *unitData;
@property (nonatomic, assign) NSInteger turnNumber;

- (id)initForGKPlayer:(GKPlayer *)player;
- (void)resetUnits;
- (void)addUnit:(Unit *)unit;
- (Unit *)unitForTag:(NSInteger)tag;

- (NSDictionary *)toDictionary;

@end
