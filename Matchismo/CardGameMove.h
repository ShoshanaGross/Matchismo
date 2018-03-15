// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

NS_ASSUME_NONNULL_BEGIN

/// Enum that represents set card symbol.
typedef NS_ENUM(NSInteger, MoveType) {
  MoveTypeChoise,
  MoveTypeMatch,
  MoveTypeMismatch
};

/// Object that represents a move in a card game.
@interface CardGameMove : NSObject

/// Designated initializer.
- (instancetype)initWithType:(MoveType)type score:(NSUInteger)score
                 chosenCards:(NSArray *)chosenCards NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/// Represents the type of the move.
@property (nonatomic) MoveType moveType;

/// Represents the score for the move.
@property (nonatomic) NSUInteger score;

/// Array of the cards chosen in this move.
@property (nonatomic, strong) NSArray *chosenCards;

@end

NS_ASSUME_NONNULL_END
