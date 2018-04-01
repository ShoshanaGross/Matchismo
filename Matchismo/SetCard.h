// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Card.h"

/// Enum that represents set card symbol.
typedef NS_ENUM(NSInteger, SetCardSymbol) {
  SetCardSymbolDiamond, /// Set card with diamond symbol.
  SetCardSymbolSquiggle, /// Set card with squiggle symbol.
  SetCardSymbolOval /// Set card with oval symbol.
};

/// Enum that represents set card color.
typedef NS_ENUM(NSInteger, SetCardColor){
  SetCardColorGreen, /// Set card with Green color.
  SetCardColorPurple, /// Set card with Purple color.
  SetCardColorRed /// Set card with Red color.
};

/// Enum that represents set card shading.
typedef NS_ENUM(NSInteger, SetCardShading) {
  SetCardShadingSolid, /// Set card with Solid shading.
  SetCardShadingStriped, /// Set card with stripped shading.
  SetCardShadingOpen /// Set card without shading.
};

NS_ASSUME_NONNULL_BEGIN

/// Object that represents a set card, which is composed of 4 attributes: number, color, symbol
/// and shading.
@interface SetCard : Card

/// Number of the card.
@property (readonly, nonatomic) NSInteger number;

/// Color of the card.
@property (readonly, nonatomic) SetCardColor color;

/// Symbol of the card.
@property (readonly, nonatomic) SetCardSymbol symbol;

/// Shading of the card.
@property (readonly, nonatomic) SetCardShading shading;

- (instancetype)initWithNumber:(NSInteger)number color:(SetCardColor)color
                        symbol:(SetCardSymbol)symbol
                       shading:(SetCardShading)shading NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
