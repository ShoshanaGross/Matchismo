// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardGameHistory.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameHistory()

/// Array of events that happend during the game
@property (strong, nonatomic, readwrite) NSMutableArray *moves;

@end

@implementation CardGameHistory

- (instancetype)init {
  if (self = [super init]) {
    _moves = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)addMove:(CardGameMove *)move{
  [self.moves addObject:move];
}
@end

NS_ASSUME_NONNULL_END
