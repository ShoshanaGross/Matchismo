// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// Represents the View of a card.
@interface CardView : UIView

/// Returns the scale factor for a card view corner.
- (CGFloat)cornerScaleFactor;

/// Returns the corner radius for a card view.
- (CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
