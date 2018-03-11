// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "Move.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Move

- (instancetype)initMove:(MoveType)moveType
              usingCards:(NSMutableArray *)cards
{
    self = [super init];
    if (self) {
        self.moveType = moveType;
        self.cards = cards;
    }
    return self;
}

- (instancetype)initMove:(MoveType)moveType
      usingCards:(NSMutableArray *)cards
       withScore:(NSUInteger) score
{
    self = [self initMove:moveType usingCards:cards];
    if (self){
        self.score = score;
    }
    return self;
}

- (void)updateMove:(MoveType)moveType
        usingCards:(NSMutableArray *)cards
         withScore:(NSUInteger)score{
    self.moveType = moveType;
    self.cards = cards;
    self.score = score;

}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

@end

NS_ASSUME_NONNULL_END
