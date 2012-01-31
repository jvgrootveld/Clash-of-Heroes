//
//  CDStats.h
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/29/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDPlayer;

@interface CDStats : NSManagedObject

//error in name: gamesPlayerGalen...

@property (nonatomic, retain) NSNumber *gamesPlayedEldurin;
@property (nonatomic, retain) NSNumber *gamesPlayerGalen;
@property (nonatomic, retain) NSNumber *gamesPlayedGarrick;
@property (nonatomic, retain) NSNumber *totalMetersMoved;
@property (nonatomic, retain) NSNumber *totalDamageDealt;
@property (nonatomic, retain) NSNumber *totalDamageTaken;
@property (nonatomic, retain) NSNumber *gamesWon;
@property (nonatomic, retain) CDPlayer *player;

- (NSInteger)totalGamesPlayed;
- (NSDictionary *)toDictionary;

@end
