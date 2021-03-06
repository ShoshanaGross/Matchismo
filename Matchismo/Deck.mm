// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck()

// Array of cards in the deck.
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
  if(atTop) {
    [self.cards insertObject:card atIndex:0];
    return;
  }
  [self.cards addObject:card];
}

- (void)addCard:(Card *)card {
  [self addCard:card atTop:NO];
}

-(nullable Card *)drawRandomCard {
  if(!self.cards.count) {
    return nil;
  }
  unsigned index = arc4random() % [self.cards count];
  Card *randomCard = self.cards[index];
  [self.cards removeObjectAtIndex:index];
  return randomCard;
}

@end

NS_ASSUME_NONNULL_END
