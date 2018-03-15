// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCard

- (NSString *)contents {
  NSArray *rankStrings = [PlayingCard rankStrings];
  NSString *contents = [NSString stringWithFormat:@"%@ %@",  rankStrings[self.rank], self.suit];
  return contents;
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
  if ([[PlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString *)suit {
  return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits {
  return @[@"♣️", @"♠️", @"♥️", @"♦️"];
}

+ (NSArray *)rankStrings {
  return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q",@"K"];
}

+ (NSUInteger)maxRank {
  return [[PlayingCard rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank {
  if (rank <= [PlayingCard maxRank]) {
      _rank = rank;
  }
}

- (int)match:(NSArray *)otherCards {
  if (otherCards.count == 1) {
    return [self calcScore:[otherCards firstObject]];
  }
  return 0;
}

// Methode that returns the score of matching 2 cards.
- (int)calcScore:(PlayingCard *)otherCard {
  if (otherCard.rank == self.rank) {
    return 4;
  }
  else if (otherCard.suit == self.suit){
    return 1;
  }
  return 0;
}

@end

NS_ASSUME_NONNULL_END
