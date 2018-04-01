// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

NS_ASSUME_NONNULL_BEGIN

@class Card, Deck;

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
- (nullable Card *)cardAtIndex:(NSUInteger)index;

/// Method to remove \card from game.
-(void)removeCard:(Card *)card;

/// Method to add given amount of cards to the game.
-(void)addCardsFromDeck:(NSUInteger)cardsCount;

/// Abstract method. Returns YES if the number of chosen cards is adequate for checking for
/// a match, which for a regular matching game means there are 2 chosen cards, and for a set game
/// means there are 3 chosen cards. If not, returns NO.
- (BOOL)shouldCheckForMatch:(NSArray *)chosenCards;

/// Score of the game.
@property (nonatomic, readonly) NSInteger score;

/// Array of cards that participates in the game.
@property (nonatomic, strong) NSArray *cards;

@end

NS_ASSUME_NONNULL_END
