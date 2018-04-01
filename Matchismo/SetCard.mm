// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "SetCard.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@implementation SetCard

- (instancetype)initWithNumber:(NSInteger)number color:(SetCardColor)color
                        symbol:(SetCardSymbol)symbol
                       shading:(SetCardShading)shading {
  if (self = [super init]) {
    _number = number;
    _color = color;
    _symbol = symbol;
    _shading = shading;
  }
  return self;
}

- (int)match:(NSArray *)otherCards {
  if (otherCards.count == 2) {
    return [self calculateMatchScore:otherCards];
  }
  return 0;
}

- (int)calculateMatchScore:(NSArray< SetCard *>*)otherCards {
  NSMutableArray *chosenCardsArray = [NSMutableArray arrayWithArray:otherCards];
  [chosenCardsArray addObject:self];
  NSMutableSet *cardsNumbersSet = [NSMutableSet setWithCapacity:3];
  NSMutableSet *cardsColorsSet = [NSMutableSet setWithCapacity:3];
  NSMutableSet *cardsSymbolsSet = [NSMutableSet setWithCapacity:3];
  NSMutableSet *cardsShadingsSet = [NSMutableSet setWithCapacity:3];
  for (SetCard *card in chosenCardsArray){
    [cardsNumbersSet addObject:@(card.number)];
    [cardsColorsSet addObject:@(card.color)];
    [cardsSymbolsSet addObject:@(card.symbol)];
    [cardsShadingsSet addObject:@(card.shading)];
  }
  return ([self isSetSizeMatchGameRules:cardsNumbersSet] &&
          [self isSetSizeMatchGameRules:cardsColorsSet] &&
          [self isSetSizeMatchGameRules:cardsSymbolsSet] &&
          [self isSetSizeMatchGameRules:cardsShadingsSet]) ? 12 : 0;
}

const static int kAttributesAreAllTheSame = 1;
const static int kAttributesAreAllDifferent = 3;


- (BOOL)isSetSizeMatchGameRules:(NSSet *)cardsSet {
  return (cardsSet.count == kAttributesAreAllTheSame ||
          cardsSet.count == kAttributesAreAllDifferent) ? YES : NO;
}

- (NSString *)contents {
  NSString *title = @"";
  for (int i = 0; i < self.number; i++) {
    title = [NSString stringWithFormat:@"%@ %@", title, [self symbolOnCard]];
  }
  CGFloat alpha = [self shadingAtrribute];
  UIColor *forgroundColor = [[self colorAtrribute] colorWithAlphaComponent:alpha];
  UIColor *strokeColor = [self colorAtrribute];
  NSMutableAttributedString *attributedTitle =
  [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:forgroundColor,
                       NSStrokeWidthAttributeName:@-3,
                       NSStrokeColorAttributeName:strokeColor}];
  return (NSString *)attributedTitle;
}

- (UIColor *)colorAtrribute {
  switch (self.color) {
    case SetCardColorGreen:
      return [UIColor greenColor];
    case SetCardColorRed:
      return [UIColor redColor];
    case SetCardColorPurple:
      return [UIColor purpleColor];
  }
}

- (NSString *)symbolOnCard {
  switch (self.symbol) {
    case SetCardSymbolOval:
      return @"●";
    case SetCardSymbolDiamond:
      return @"▲";
    case SetCardSymbolSquiggle:
      return @"■";
  }
}

- (float)shadingAtrribute{
  switch (self.shading) {
    case SetCardShadingOpen:
      return 0;
    case SetCardShadingStriped:
      return 0.3;
    case SetCardShadingSolid:
      return 1;
  }
}

@end

NS_ASSUME_NONNULL_END
