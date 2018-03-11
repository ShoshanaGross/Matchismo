// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Card

- (int)match:(NSArray *)otherCards {
  for (Card *card in otherCards) {
    if([card.contents isEqualToString:self.contents]){
      return 1;
    }
  }
  return 0;
}
@end

NS_ASSUME_NONNULL_END
