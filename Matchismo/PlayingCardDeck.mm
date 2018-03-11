// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "PlayingCardDeck.h"

#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardDeck

- (void)createDeck
{
    NSUInteger maxRank = [PlayingCard maxRank];
    NSArray *validSuits = [PlayingCard validSuits];
    for (NSUInteger i=1; i <= maxRank; i++){
        for (NSString *suit in validSuits){
            PlayingCard *card =[[PlayingCard alloc] init];
            card.suit = suit;
            card.rank = i;
            //NSLog(@"created card with rank (%d) suit(%@)", card.rank, card.suit);
            [self addCard:card];
            
        }
    }
}
@end

NS_ASSUME_NONNULL_END
