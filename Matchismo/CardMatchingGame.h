// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GameMode) {
  GameModeTwoCardsMatch,
  GameModeThreeCardsMatch
};

/// Object that represents a card matching game.
@interface CardMatchingGame : NSObject

/// Designated Initializer, which initializes with number of cards in the game, a deck to
/// take cards from, and the mode of the game - 2 or 3 cards match.
- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck mode:(GameMode)mode
    NS_DESIGNATED_INITIALIZER;

/// Initializes with number of cards in the game, and a deck to take cards from.
- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck;

/// Default Inititializer unavailable.
- (instancetype)init NS_UNAVAILABLE;

/// Method to choose card by a given index in the deck and check the match.
- (void)chooseCardAtIndex:(NSUInteger)index;

/// Method to return card at a given index in the deck.
- (Card *)cardAtIndex:(NSUInteger)index;

/// Score of the game.
@property (nonatomic, readonly) NSInteger score;

/// Mode of the game - 2 cards match or 3 cards match.
@property (nonatomic) GameMode mode;

/// Description of last move in the game.
@property (nonatomic, strong, readonly) NSString *moveDescription;

@end

NS_ASSUME_NONNULL_END
