// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "SetViewController.h"

#import "SetCardDeck.h"
#import "SetMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetViewController

- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (CardMatchingGame *) createGameWithCardCount:(NSUInteger)count deck:(Deck *)deck{
  return [[SetMatchingGame alloc] initWithCardCount:count deck:deck];
}

- (NSAttributedString *)titleForCard:(Card *)card{
  return (NSAttributedString *) card.contents;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:@"cardfront"];
}

-(UIColor *)backgroundColorForCard:(Card *)card {
  return card.isChosen ? [UIColor grayColor] : nil;
}
  
@end

NS_ASSUME_NONNULL_END
