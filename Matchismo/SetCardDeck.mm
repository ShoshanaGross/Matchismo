// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "SetCardDeck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardDeck

- (instancetype)init {
  if (self = [super init]) {
    for (NSInteger number = 1; number <= 3; number++) {
      for (int symbol = SetCardSymbolDiamond; symbol <= SetCardSymbolOval; symbol++) {
        for (int color = SetCardColorGreen; color <= SetCardColorRed; color ++) {
          for (int shading = SetCardSahdingSolid; shading <= SetCardSahdingOpen; shading ++) {
            SetCard *card =[[SetCard alloc] init];
            card.number = number;
            card.symbol = (SetCardSymbol)symbol;
            card.color = (SetCardColor)color;
            card.shading = (SetCardSahding)shading;
            [self addCard:card];
          }
        }
      }
    }
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
