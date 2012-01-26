//
//  UnitData.h
//  ClashOfHeroes
//
//  Created by Chris Kievit on 26-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitData : NSObject

@property (nonatomic, strong) NSString *unitType;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) NSInteger currentHealth;

- (id)initWithType:(NSString *)type tag:(NSInteger)tag andLocation:(CGPoint)location;
- (NSDictionary *)toDictionary;

@end
