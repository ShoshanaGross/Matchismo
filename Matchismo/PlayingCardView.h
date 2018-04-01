// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

/// Represnts the view of a playing card.
@interface PlayingCardView : CardView

/// Initializer that creates a playing card view with \c rank and \c suit.
- (instancetype)initWithFrame:(CGRect)frame rank:(NSUInteger)rank suit:(NSString *)suit;

/// Specifies if a card is faced up or not.
@property (nonatomic) BOOL faceUp;

/// Specifies if card is matched or not.
@property (nonatomic) BOOL matched;

@end

NS_ASSUME_NONNULL_END
