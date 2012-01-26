//
//  Hero.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 26-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic, strong) NSString *heroName;
@property (nonatomic, assign) NSInteger currentHealth;
@property (nonatomic, strong) NSString *abilityOne;
@property (nonatomic, strong) NSString *abilityTwo;
@property (nonatomic, strong) NSString *abilityThree;
@property (nonatomic, strong) NSString *abilityFour;

- (NSDictionary *)toDictionary;

@end
