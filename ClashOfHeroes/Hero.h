//
//  Hero.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 26-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Unit.h"

@interface Hero : Unit

@property (nonatomic, strong) NSString *heroName;
@property (nonatomic, assign) NSInteger currentHealth;
@property (nonatomic, strong) NSString *abilityOne;
@property (nonatomic, strong) NSString *abilityTwo;
@property (nonatomic, strong) NSString *abilityThree;
@property (nonatomic, strong) NSString *abilityFour;

@property (nonatomic, assign) NSInteger bonusPhysicalAttackPower;
@property (nonatomic, assign) NSInteger bonusMagicalAttackPower;
@property (nonatomic, assign) NSInteger bonusPhysicalDefensePower;
@property (nonatomic, assign) NSInteger bonusMagicalDefensePower;
@property (nonatomic, assign) NSInteger bonusHealthPoints;
@property (nonatomic, assign) NSInteger bonusRange;
@property (nonatomic, assign) NSInteger bonusMovement;

- (NSDictionary *)toDictionary;
- (void)setBonusForAbilities;

@end
