//
//  Hero.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 26-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "Hero.h"

@implementation Hero

@synthesize heroName = _heroName;
@synthesize currentHealth = _currentHealth;
@synthesize abilityOne = _abilityOne;
@synthesize abilityTwo = _abilityTwo;
@synthesize abilityThree = _abilityThree;
@synthesize abilityFour = _abilityFour;

@synthesize bonusRange = _bonusRange;
@synthesize bonusHealthPoints = _bonusHealthPoints;
@synthesize bonusMagicalAttackPower = _bonusMagicalAttackPower;
@synthesize bonusMagicalDefensePower = _bonusMagicalDefensePower;
@synthesize bonusMovement = _bonusMovement;
@synthesize bonusPhysicalAttackPower = _bonusPhysicalAttackPower;
@synthesize bonusPhysicalDefensePower = _bonusPhysicalDefensePower;

- (id)init
{
    if (self = [super init])
    {
        self.heroName = @"";
        self.currentHealth = 0;
        self.abilityOne = @"";
        self.abilityTwo = @"";
        self.abilityThree = @"";
        self.abilityFour = @"";
        
        self.bonusPhysicalDefensePower = 0;
        self.bonusRange = 0;
        self.bonusPhysicalAttackPower = 0;
        self.bonusMovement = 0;
        self.bonusMagicalDefensePower = 0;
        self.bonusMagicalAttackPower = 0;
        self.bonusHealthPoints = 0;
    }
    
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *heroDict = [NSMutableDictionary dictionary];
    
    [heroDict setValue:self.heroName forKey:@"heroName"];
    [heroDict setValue:[NSNumber numberWithInteger:self.currentHealth] forKey:@"health"];
    [heroDict setValue:self.abilityOne forKey:@"abilityOne"];
    [heroDict setValue:self.abilityTwo forKey:@"abilityTwo"];
    [heroDict setValue:self.abilityThree forKey:@"abilityThree"];
    [heroDict setValue:self.abilityFour forKey:@"abilityFour"];
    
    return heroDict;
}

- (void)dealloc
{
    [self.heroName dealloc];
    [self.abilityOne dealloc];
    [self.abilityTwo dealloc];
    [self.abilityThree dealloc];
    [self.abilityFour dealloc];
    
    [super dealloc];
}

@end
