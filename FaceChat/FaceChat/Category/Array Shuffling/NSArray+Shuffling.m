//
//  NSArray+Shuffling.m
//  FaceChat
//
//  Created by Sourcebits on 31/08/15.
//  Copyright (c) 2015 glasslo. All rights reserved.
//

#import "NSArray+Shuffling.h"

@implementation NSArray (Shuffling)

- (NSArray *)shuffledArray
{
    NSMutableArray *shuffledArray = [self mutableCopy];
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return [shuffledArray copy];
}

@end
