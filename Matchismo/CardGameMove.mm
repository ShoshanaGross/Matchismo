// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardGameMove.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardGameMove

- (instancetype)initWithType:(MoveType)type score:(NSUInteger)score
                 chosenCards:(NSArray *)chosenCards{
  if(self = [super init]) {
    _moveType = type;
    _score = score;
    _chosenCards = chosenCards;
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
