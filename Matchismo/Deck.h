// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that represents a deck of cards.
@interface Deck : NSObject

/// Method to add card to the deck at the top.
- (void)addCard:(Card *)card atTop:(BOOL)atTop;

/// Method to add card to the deck.
- (void)addCard:(Card *)card;

/// Method that returns a random card drawn from the deck. If deck is empty returns nil.
-(Card *)drawRandomCard;

@end

NS_ASSUME_NONNULL_END
