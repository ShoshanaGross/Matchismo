// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

NS_ASSUME_NONNULL_BEGIN

@interface Move : NSObject
typedef enum moveTypes
{
    CHOISE,
    MATCH,
    MISMATCH
} MoveType;

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic) NSUInteger score;
@property (nonatomic) MoveType moveType;

- (instancetype)initMove:(MoveType)moveType
              usingCards:(NSArray *)cards;

- (instancetype)initMove:(MoveType)moveType
     usingCards:(NSMutableArray *)cards
      withScore:(NSUInteger) score;

- (void)updateMove:(MoveType)moveType
        usingCards:(NSMutableArray *)cards
         withScore:(NSUInteger)score;
@end

NS_ASSUME_NONNULL_END
