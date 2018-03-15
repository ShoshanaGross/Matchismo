// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardGameMove.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that represents the history of a card game.
@interface CardGameHistory : NSObject

/// Add crad game move to history.
- (void)addMove:(CardGameMove *)move;

/// Array of events that happend during the game
@property (strong, nonatomic, readonly) NSMutableArray *moves;

@end

NS_ASSUME_NONNULL_END
