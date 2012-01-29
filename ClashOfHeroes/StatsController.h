//
//  StatsController.h
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/29/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDPlayer, CDStats;

@interface StatsController : NSObject

#pragma mark - SET
+ (CDPlayer *)newPlayerAndStatsForPlayerWithGameCenterId:(NSString *)gameCenterId;

#pragma mark - GET
+ (CDPlayer *)playerForGameCenterId:(NSString *)gameCenterId;

#pragma mark - UPDATE
+ (BOOL)addGamesPlayedEldurin:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId;
+ (BOOL)addGamesPlayedGarrick:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId;
+ (BOOL)addGamesPlayedGalen:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId;
+ (BOOL)addTotalDamageDealt:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId;
+ (BOOL)addTotalDamageTaken:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId;
+ (BOOL)addTotalMetersMoved:(NSInteger)addGamesPlayed forPlayer:(NSString *)gameCenterId;

@end
