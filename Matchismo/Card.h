// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

NS_ASSUME_NONNULL_BEGIN
/// Object that represnt a card.
@interface Card : NSObject

/// Methode to match card with an array of given cards and return a score.
- (int)match:(NSArray *)otherCards;

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

@end
NS_ASSUME_NONNULL_END
