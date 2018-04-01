// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Card, CardView, CardMatchingGame, Deck;

/// Controller for the card game view. Abstract class.
@interface CardGameViewController : UIViewController

/// Abstract method to create a deck. Default return value is \c nil.
- (nullable Deck *)createDeck;

/// Abstract method to create a card game with \c count which is the number of cards in the game,
/// and the \c deck to choose cards from. Default return value is \c nil.
- (nullable CardMatchingGame *)createGameWithCardCount:(NSUInteger)count deck:(Deck *)deck;

/// Method that updates the UI.
- (void)updateUI;

/// Abstract method that creates a \c cardView from a given \c card in a given \c frame.
- (nullable CardView *)createViewFromCard:(Card *)card frame:(CGRect)frame;

/// Method that sets up a new \c cardView at a given \c index.
- (void)setupNewCardView:(CardView *)cardView atIndex:(NSUInteger)index;

/// Method that deals with pinch gesture by collecting the cards into a deck in the center
/// of the screen.
- (IBAction)pinch:(UISwipeGestureRecognizer *)sender;

/// Method that deals with tap gesture by enabling moving the deck around, after the
/// cards have been pinched.
- (void)tap:(UIPanGestureRecognizer *)sender;

/// Method that deals with user touching the deal button, by creating a new game.
- (IBAction)touchDealButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
