// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "SetMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck {
  return [super initWithCardCount:count deck:deck];
}

static const int kNUM_OF_CARDS_FOR_SET = 2;

- (BOOL)shouldCheckForMatch:(NSArray *)chosenCards {
  if (chosenCards.count == kNUM_OF_CARDS_FOR_SET) {
    return YES;
  }
  return NO;
}

@end

NS_ASSUME_NONNULL_END
