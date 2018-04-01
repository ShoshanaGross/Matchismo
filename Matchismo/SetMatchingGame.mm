// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "SetMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN
@interface SetMatchingGame()

// Currently chosen cards;
@property (nonatomic) NSMutableArray< Card *> *chosenCards;

@end

@implementation SetMatchingGame

static const int kNumberOfCardsForSet = 3;

- (BOOL)shouldCheckForMatch:(NSArray *)chosenCards {
  return chosenCards.count == kNumberOfCardsForSet;
}

@end

NS_ASSUME_NONNULL_END
