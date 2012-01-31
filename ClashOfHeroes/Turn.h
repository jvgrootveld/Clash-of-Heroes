//
//  Turn.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Turn : NSObject

@property (nonatomic) NSInteger totalMetersMoved;
@property (nonatomic) NSInteger totalDamageDealt;
@property (nonatomic) NSInteger totalDamageTaken;

- (void)addToTotalMetersMoved:(NSInteger)totalMetersMoved;
- (void)addToTotalDamageDealt:(NSInteger)totalDamageDealt;
- (void)addToTotalDamageTaken:(NSInteger)totalDamageTaken;
- (void)reset;

@end
