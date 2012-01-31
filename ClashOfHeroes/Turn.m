//
//  Turn.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "Turn.h"

@implementation Turn

@synthesize totalMetersMoved = _totalMetersMoved;
@synthesize totalDamageDealt = _totalDamageDealt;
@synthesize totalDamageTaken = _totalDamageTaken;

- (id)init
{
    if (self = [super init])
    {
        [self reset];
    }
    
    return self;
}

- (void)addToTotalMetersMoved:(NSInteger)totalMetersMoved
{
    _totalMetersMoved += totalMetersMoved;
}

- (void)addToTotalDamageDealt:(NSInteger)totalDamageDealt
{
    _totalDamageDealt += totalDamageDealt;
}

- (void)addToTotalDamageTaken:(NSInteger)totalDamageTaken
{
    _totalDamageTaken += totalDamageTaken;
}

- (void)reset
{
    [self setTotalMetersMoved:0];
    [self setTotalDamageDealt:0];
    [self setTotalDamageTaken:0];
}

- (NSString *)description
{
    NSMutableDictionary *printDictionairy = [NSMutableDictionary dictionary];
    
    [printDictionairy setValue:[NSString stringWithFormat:@"%d", _totalMetersMoved] forKey:@"totalMetersMoved"];
    [printDictionairy setValue:[NSString stringWithFormat:@"%d", _totalDamageDealt] forKey:@"totalDamageDealt"];
    [printDictionairy setValue:[NSString stringWithFormat:@"%d", _totalDamageTaken] forKey:@"totalDamageTaken"];
    
    return [printDictionairy description];
}

@end
