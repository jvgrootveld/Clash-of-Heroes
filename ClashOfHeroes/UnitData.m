//
//  UnitData.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 26-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "UnitData.h"

@implementation UnitData

@synthesize unitType = _unitType;
@synthesize tag = _tag;
@synthesize location = _location;
@synthesize currentHealth = _currentHealth;
@synthesize unitName = _unitName;

- (id)initWithType:(NSInteger)type name:(NSString *)name tag:(NSInteger)tag andLocation:(CGPoint)location
{
    if (self == [super init])
    {
        self.unitType = type;
        self.unitName = name;
        self.tag = tag;
        self.location = location;
        self.currentHealth = 100;
    }
    
    return self;
}

- (id)initWithName:(NSString *)name tag:(NSInteger)tag andLocation:(CGPoint)location
{
    if (self = [super init])
    {
        self.unitName = name;
        self.tag = tag;
        self.location = location;
        
        if ([name isEqualToString:@"warrior"]) self.unitType = WARRIOR;
        else if ([name isEqualToString:@"mage"]) self.unitType = MAGE;
        else if ([name isEqualToString:@"ranger"]) self.unitType = RANGER;
        else if ([name isEqualToString:@"priest"]) self.unitType = PRIEST;
        else if ([name isEqualToString:@"shapeshifter"]) self.unitType = SHAPESHIFTER;
    }
    
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    //Key-value pairs have to match pairs given by a Unit object
    [dataDict setValue:[NSNumber numberWithInteger:self.unitType] forKey:@"unitType"];
    [dataDict setValue:self.unitName forKey:@"unitName"];
    [dataDict setValue:[NSNumber numberWithInteger:self.tag] forKey:@"tag"];
    [dataDict setValue:[NSValue valueWithCGPoint:self.location] forKey:@"location"];
    [dataDict setValue:[NSNumber numberWithInteger:self.currentHealth] forKey:@"health"];
    
    return dataDict;
}

- (void)dealloc
{
    [self.unitName dealloc];
    
    [super dealloc];
}

@end
