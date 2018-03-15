// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "PlayingCardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardMatchingGame

static const int kNUM_OF_CARDS_TO_MATCH = 1;

- (BOOL)shouldCheckForMatch:(NSArray *)chosenCards {
  if (chosenCards.count == kNUM_OF_CARDS_TO_MATCH) {
    return YES;
  }
  return NO;
}

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck {
  return [super initWithCardCount:count deck:deck];
}

@end

NS_ASSUME_NONNULL_END
