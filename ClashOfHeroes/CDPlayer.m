//
//  CDPlayer.m
//  ClashOfHeroes
//
//  Created by Justin van Grootveld on 1/29/12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "CDPlayer.h"
#import "CDStats.h"

@implementation CDPlayer

@dynamic gameCenterId;
@dynamic stats;

- (NSString *)description
{
    NSMutableDictionary *printDictionairy = [NSMutableDictionary dictionary];
    
    [printDictionairy setValue:self.gameCenterId forKey:@"gameCenterId"];
    if(self.stats) [printDictionairy setValue:[(CDStats *)self.stats toDictionary] forKey:@"Stats"];
    
    return [printDictionairy description];
}

@end
