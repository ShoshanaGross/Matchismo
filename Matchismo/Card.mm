// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Card
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    return score;
}
@end
NS_ASSUME_NONNULL_END
