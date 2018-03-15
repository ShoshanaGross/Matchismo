// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

NS_ASSUME_NONNULL_BEGIN

@class Card, CardGameHistory, Deck;

/// Object that represents a card matching game.
@interface CardMatchingGame : NSObject

/// Designated Initializer, which initializes with number of cards in the game and deck to
/// take cards from.
- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck
    NS_DESIGNATED_INITIALIZER;

/// Default Inititializer unavailable.
- (instancetype)init NS_UNAVAILABLE;

/// Method to choose card by a given index in the deck and check the match.
- (void)chooseCardAtIndex:(NSUInteger)index;

/// Method to return card at a given index in the deck.
- (Card *)cardAtIndex:(NSUInteger)index;

/// Abstract method. Returns YES if the number of chosen cards is adequate for checking for
/// a match, NO otherwise.
- (BOOL)shouldCheckForMatch:(NSArray *)chosenCards;

/// Score of the game.
@property (nonatomic, readonly) NSInteger score;

/// History of the game.
@property (nonatomic, strong, readonly) CardGameHistory *history;

@end

NS_ASSUME_NONNULL_END
