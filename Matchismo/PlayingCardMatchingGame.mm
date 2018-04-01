// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "PlayingCardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardMatchingGame

static const int kNumberOfCardsToMatch = 2;

- (BOOL)shouldCheckForMatch:(NSArray *)chosenCards {
  return chosenCards.count == kNumberOfCardsToMatch;
}

@end

NS_ASSUME_NONNULL_END
