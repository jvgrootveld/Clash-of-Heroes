//
//  Turn.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 09-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "Turn.h"

@implementation Turn

@synthesize movements = _movements, actions = _actions, hero = _hero;

- (id)init
{
    if (self = [super init])
    {
        _hero = nil;
        _movements = [NSMutableArray array];
        _actions = [NSMutableArray array];
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init])
    {
        self.hero = [dictionary objectForKey:@"hero"];
        
        for (NSDictionary *movement in [dictionary objectForKey:@"movements"])
        {
            [self.movements addObject:movement];
        }
        
        for (NSDictionary *action in [dictionary objectForKey:@"actions"])
        {
            [self.actions addObject:action];
        }
    }
    
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *turnDictionary = [NSMutableDictionary dictionary];
    
//    if (self.hero) [turnDictionary setValue:self.hero forKey:@"hero"];
//    if (self.movements.count > 0) [turnDictionary setValue:self.movements forKey:@"movements"];
//    if (self.actions.count > 0) [turnDictionary setValue:self.actions forKey:@"actions"];
    
    NSMutableDictionary *hero = [NSMutableDictionary dictionary];
    [hero setValue:@"3" forKey:@"heroID"];
    [hero setValue:@"1" forKey:@"heroAbilityOne"];
    [hero setValue:@"2" forKey:@"heroAbilityTwo"];
    [hero setValue:@"3" forKey:@"heroAbilityThree"];
    [hero setValue:@"4" forKey:@"heroAbilityFour"];
    
    NSMutableDictionary *units = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *warriorUnit = [NSMutableDictionary dictionary];
    [warriorUnit setValue:@"30" forKey:@"currentHP"];
    [warriorUnit setValue:[NSValue valueWithCGPoint:CGPointMake(1, 1)] forKey:@"spriteLocation"];
    [units setValue:warriorUnit forKey:@"warriorUnit"];
    
    NSMutableDictionary *mageUnit = [NSMutableDictionary dictionary];
    [mageUnit setValue:@"40" forKey:@"currentHP"];
    [mageUnit setValue:[NSValue valueWithCGPoint:CGPointMake(1, 1)] forKey:@"spriteLocation"];
    [units setValue:mageUnit forKey:@"mageUnit"];
    
    NSMutableDictionary *rangerUnit = [NSMutableDictionary dictionary];
    [rangerUnit setValue:@"40" forKey:@"currentHP"];
    [rangerUnit setValue:[NSValue valueWithCGPoint:CGPointMake(1, 1)] forKey:@"spriteLocation"];
    [units setValue:rangerUnit forKey:@"rangerUnit"];
    
    NSMutableDictionary *priestUnit = [NSMutableDictionary dictionary];
    [priestUnit setValue:@"40" forKey:@"currentHP"];
    [priestUnit setValue:[NSValue valueWithCGPoint:CGPointMake(1, 1)] forKey:@"spriteLocation"];
    [units setValue:priestUnit forKey:@"priestUnit"];
    
    NSMutableDictionary *shapeshifterUnit = [NSMutableDictionary dictionary];
    [shapeshifterUnit setValue:@"40" forKey:@"currentHP"];
    [shapeshifterUnit setValue:[NSValue valueWithCGPoint:CGPointMake(1, 1)] forKey:@"spriteLocation"];
    [units setValue:shapeshifterUnit forKey:@"shapeshifterUnit"];
    
    [turnDictionary setValue:hero forKey:@"hero"];
    [turnDictionary setValue:units forKey:@"units"];
    
    return turnDictionary;
}

@end
