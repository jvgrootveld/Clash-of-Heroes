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

- (id)initWithType:(NSString *)type tag:(NSInteger)tag andLocation:(CGPoint)location
{
    if (self == [super init])
    {
        self.unitType = type;
        self.tag = tag;
        self.location = location;
        self.currentHealth = 100;
    }
    
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    //Key-value pairs have to match pairs given by a Unit object
    [dataDict setValue:self.unitType forKey:@"unitName"];
    [dataDict setValue:[NSNumber numberWithInteger:self.tag] forKey:@"tag"];
    [dataDict setValue:[NSValue valueWithCGPoint:self.location] forKey:@"location"];
    [dataDict setValue:[NSNumber numberWithInteger:self.currentHealth] forKey:@"health"];
    
    return dataDict;
}

- (void)dealloc
{
    [self.unitType dealloc];
    
    [super dealloc];
}

@end