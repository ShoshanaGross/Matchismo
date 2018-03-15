// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "PlayingCardGameViewController.h"

#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *) createGameWithCardCount:(NSUInteger)count deck:(Deck *)deck{
  return [[PlayingCardMatchingGame alloc] initWithCardCount:count deck:deck];
}

- (NSAttributedString *)titleForCard:(Card *)card {
  NSAttributedString *contents = [[NSAttributedString alloc] initWithString:card.contents];
  return card.isChosen ? contents: nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen? @"cardfront" : @"cardback"];
}

@end

NS_ASSUME_NONNULL_END
