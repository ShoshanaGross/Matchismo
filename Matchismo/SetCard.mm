// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "SetCard.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@implementation SetCard

- (int)match:(NSArray *)otherCards {
  if (otherCards.count == 2) {
    return [self calcMatchScore:otherCards];
  }
  return 0;
}

- (int)calcMatchScore:(NSArray *)otherCards {
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
  if ([self isSetValid:cardsNumbersSet] && [self isSetValid:cardsColorsSet] &&
      [self isSetValid:cardsSymbolsSet] && [self isSetValid:cardsShadingsSet]) {
    return 12;
  }
  return 0;
}

- (BOOL)isSetValid:(NSSet *)cardsSet {
  if (cardsSet.count == 1 || cardsSet.count == 3){
    return YES;
  }
  return NO;
}

- (NSString *)contents {
  NSString *title = @"";
  for (int i = 0; i < self.number; i++) {
    title = [NSString stringWithFormat:@"%@ %@", title, [self symbolOnCard]];
  }
  //UIColor *color = [self colorAtrribute];
  float alpha = [self shadingAtrribute];
  UIColor *forgroundColor = [[self colorAtrribute] colorWithAlphaComponent:alpha];
  UIColor *strokeColor = [self colorAtrribute];
  NSMutableAttributedString *attributedTitle =
  [[NSMutableAttributedString alloc] initWithString:title attributes:@{
      NSForegroundColorAttributeName:forgroundColor, NSStrokeWidthAttributeName: @-3,
      NSStrokeColorAttributeName: strokeColor}];
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
    default:
      return nil;
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
    default:
      return nil;
  }
}

- (float)shadingAtrribute{
  switch (self.shading) {
    case SetCardSahdingOpen:
      return 0;
    case SetCardSahdingStriped:
      return 0.3;
    case SetCardSahdingSolid:
      return 1;
    default:
      return 0;
  }
}

@end

NS_ASSUME_NONNULL_END
