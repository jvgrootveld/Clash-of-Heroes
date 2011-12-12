//
//  Upgrade.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 06-12-11.
//  Copyright (c) 2011 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Upgrade : NSObject
{
@protected
    Upgrade *_upgrade;
    NSString *_name;
    NSInteger _physicalAttackPower;
    NSInteger _magicalAttackPower;
    NSInteger _physicalDefense;
    NSInteger _magicalDefense;
    NSInteger _healthPoints;
    NSInteger _range;
    NSInteger _movement;
}

@property (nonatomic, retain) Upgrade *upgrade;

- (Upgrade *)upgrade;
- (NSString *)name;
- (NSInteger)physicalAttackPower;
- (NSInteger)magicalAttackPower;
- (NSInteger)physicalDefense;
- (NSInteger)magicalDefense;
- (NSInteger)healthPoints;
- (NSInteger)movement;
- (NSInteger)range;

- (id)initWithUpgrade:(Upgrade *)upgrade;
- (NSString *)listOfUpgrades;

@end
