// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Deck.h"
#import "Move.h"
NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                         withMode:(NSUInteger)mode;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger mode;
@property (nonatomic, strong) NSString *moveDescription;
@end

NS_ASSUME_NONNULL_END
