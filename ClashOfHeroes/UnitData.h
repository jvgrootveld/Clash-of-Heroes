//
//  UnitData.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 26-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    WARRIOR = 1,
    MAGE = 2,
    RANGER = 3,
    PRIEST = 4,
    SHAPESHIFTER = 5
};

@interface UnitData : NSObject

@property (nonatomic, assign) NSInteger unitType;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) NSInteger currentHealth;
@property (nonatomic, strong) NSString *unitName;

- (id)initWithName:(NSString *)name tag:(NSInteger)tag andLocation:(CGPoint)location;
- (id)initWithType:(NSInteger)type name:(NSString *)name tag:(NSInteger)tag andLocation:(CGPoint)location;
- (NSDictionary *)toDictionary;

@end
