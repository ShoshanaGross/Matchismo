// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that represents a playing card.
@interface PlayingCard : Card

/// Class method that returns array of valid suits represented as strings.
+ (NSArray *)validSuits;

/// Class method that returns the max rank of the cards.
+ (NSUInteger)maxRank;

/// Suit of the card.
@property (strong, nonatomic) NSString *suit;

/// Rank of the card.
@property (nonatomic) NSUInteger rank;

@end

NS_ASSUME_NONNULL_END
