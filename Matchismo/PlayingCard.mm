// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCard

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+(NSArray *)validSuits
{
    return @[@"♣️", @"♠️", @"♥️", @"♦️"];
}

-(void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count]-1;
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    // matching 2 cards
    if ([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank){
            score = 4;
        }
        else if (otherCard.suit == self.suit){
            score = 1;
        }
        
    }
    // matching 3 cards
    else if ([otherCards count] == 2){
        PlayingCard *firstCard = [otherCards firstObject];
        PlayingCard *secondCard = [otherCards objectAtIndex:1];
        if (firstCard.rank == self.rank && secondCard.rank == self.rank){
            score = 10;
        }
        else if(firstCard.suit == self.suit && secondCard.suit == self.suit){
            score = 5;
        }
        else if(firstCard.rank == self.rank || secondCard.rank == self.rank ||
                firstCard.rank == secondCard.rank){
            score = 3;
        }
        else if(firstCard.suit == self.suit || secondCard.suit == self.suit ||
                firstCard.suit == secondCard.suit){
            score = 1;
        }
    }
    return score;
}

@end

NS_ASSUME_NONNULL_END
