// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    if (self){
        self.moveDescription = [[NSString alloc] init];
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            }
            else{
                self = nil;
                break;
            }
            
        }
    }
    return self;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                         withMode:(NSUInteger)mode
{
    self = [self initWithCardCount:count usingDeck:deck];
    self.mode = mode;
    return self;
}


- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
        }
        else{
            self.moveDescription = [card contents];
            NSMutableArray *cardsToMatch = [[NSMutableArray alloc] init];
            // match against other chosen cards
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    [cardsToMatch addObject:otherCard];

                    if (self.mode == 0){
                        break;
                    }
                }
            }
            if ((self.mode == 0 && [cardsToMatch count] == 1) ||
                (self.mode == 1 && [cardsToMatch count] == 2)){
                int matchScore  = [card match:cardsToMatch];
                NSString *cardsContent = @"";
                if (matchScore){
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *chosenCard in cardsToMatch){
                        chosenCard.matched = YES;
                        cardsContent = [cardsContent stringByAppendingFormat:@"%@ ", chosenCard.contents];
                    }
                    card.matched = YES;
                    
                    self.moveDescription = [NSString stringWithFormat:@"Matched %@ %@ for %d points", card.contents, cardsContent, (matchScore * MATCH_BONUS)];
                }
                else{
                    self.score -= MISMATCH_PENALTY;
                    for (Card *chosenCard in cardsToMatch){
                        chosenCard.chosen = NO;
                        cardsContent = [cardsContent stringByAppendingFormat:@"%@ ", chosenCard.contents];

                    }
                    self.moveDescription = [NSString stringWithFormat:@"%@ %@ don't match! %d points penalty!", card.contents, cardsContent, MISMATCH_PENALTY];
                }
                
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end

NS_ASSUME_NONNULL_END
