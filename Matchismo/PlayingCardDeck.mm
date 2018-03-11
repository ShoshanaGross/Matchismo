// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardDeck

// Initializer that creates a playing cards deck.
- (instancetype)init {
  if (self = [super init]) {
    for (NSUInteger i = 1; i <= [PlayingCard maxRank]; i++) {
      for (NSString *suit in [PlayingCard validSuits]) {
        PlayingCard *card =[[PlayingCard alloc] init];
        card.suit = suit;
        card.rank = i;
        [self addCard:card];
      }
    }
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
