// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Card, CardMatchingGame, Deck;

/// Controller for the card game view. Abstract class.
@interface CardGameViewController : UIViewController

/// Abstract method to create a deck. Default return value: nil.
- (Deck *)createDeck;

/// Abstract method to create a card game. Default return value: nil.
- (CardMatchingGame *) createGameWithCardCount:(NSUInteger)count deck:(Deck *)deck;

/// Abstract method that returns title of a card. Default return value: nil.
- (NSAttributedString *)titleForCard:(Card *)card;

/// Abstract method that returns background image of a card. Default return value: nil.
- (UIImage *)backgroundImageForCard:(Card *)card;

/// Abstract method that returns background color of a card. Default return value: nil.
- (UIColor *)backgroundColorForCard:(Card *)card;

@end

NS_ASSUME_NONNULL_END
