// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Card.h"

/// Enum that represents set card symbol.
typedef NS_ENUM(NSInteger, SetCardSymbol) {
  SetCardSymbolDiamond,
  SetCardSymbolSquiggle,
  SetCardSymbolOval
};

/// Enum that represents set card color.
typedef NS_ENUM(NSInteger, SetCardColor){
  SetCardColorGreen,
  SetCardColorPurple,
  SetCardColorRed
};

/// Enum that represents set card shading.
typedef NS_ENUM(NSInteger, SetCardSahding) {
  SetCardSahdingSolid,
  SetCardSahdingStriped,
  SetCardSahdingOpen
};


NS_ASSUME_NONNULL_BEGIN

/// Object that represents a set card.
@interface SetCard : Card

/// Number of the card.
@property (nonatomic) NSInteger number;

///Color of the card.
@property (nonatomic) SetCardColor color;

/// Symbol of the card.
@property (nonatomic) SetCardSymbol symbol;

///Shading of the card.
@property (nonatomic) SetCardSahding shading;
@end

NS_ASSUME_NONNULL_END
