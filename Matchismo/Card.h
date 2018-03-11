// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

NS_ASSUME_NONNULL_BEGIN
/// Object that represnts a card.
@interface Card : NSObject

/// Method to match card with an array of given cards and return a score. Default behavior:
/// returns 1 if card contents are equal to any of the given cards contents. Otherwise, returns 0.
- (int)match:(NSArray *)otherCards;

/// Contents of a card.
@property (strong, nonatomic) NSString *contents;

/// Indicate if card is chosen by the user.
@property (nonatomic, getter=isChosen) BOOL chosen;

/// Indicate if cards is matched.
@property (nonatomic, getter=isMatched) BOOL matched;

@end

NS_ASSUME_NONNULL_END
