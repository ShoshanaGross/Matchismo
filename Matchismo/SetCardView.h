// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardView.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

/// View for a set card.
@interface SetCardView : CardView

/// Initializer that creates a set card view with \c number \c color \c symbol and \c shading.
- (instancetype)initWithFrame:(CGRect)frame number:(NSUInteger)number color:(SetCardColor)color
                       symbol:(SetCardSymbol)symbol
                      shading:(SetCardShading)shading;

@end

NS_ASSUME_NONNULL_END
