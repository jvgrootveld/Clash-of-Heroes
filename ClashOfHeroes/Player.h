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

@interface Player : NSObject

@property (nonatomic, strong) GKPlayer *gameCenterInfo;
@property (nonatomic, strong) NSObject *hero;
@property (nonatomic, strong) NSMutableArray *units;

- (id)initForGKPlayer:(GKPlayer *)player;
- (void)addUnit:(Unit *)unit;

@end
