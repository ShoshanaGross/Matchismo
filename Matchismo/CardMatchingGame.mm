// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardMatchingGame.h"

#import "Card.h"
#import "CardGameHistory.h"
#import "CardGameMove.h"
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()

// Score of the game.
@property (nonatomic, readwrite) NSInteger score;

/// History of the game.
@property (nonatomic, strong, readwrite) CardGameHistory *history;

// Array of cards that participates in the game.
@property (nonatomic, strong) NSArray *cards;

@end

@implementation CardMatchingGame

- (NSArray *)cards {
  if (!_cards) _cards = [[NSArray alloc] init];
  return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck {
  
  if (self = [super init]) {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
      Card *card = [deck drawRandomCard];
      if (card) {
          [cards addObject:card];
      }
      else {
          self = nil;
          break;
      }
    }
    self.cards = [cards copy];
    _history = [[CardGameHistory alloc] init];
  }
  return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
  Card *card = [self cardAtIndex:index];
  if (card.matched) {
    return;
  }
  if (card.isChosen) {
    card.chosen = NO;
    return;
  }
  CardGameMove *move = [[CardGameMove alloc] initWithType:MoveTypeChoise score:0
                                              chosenCards:@[card]];
  [self.history addMove:move];
  NSMutableArray *allCardsInMove = [[NSMutableArray alloc] init];
  [allCardsInMove addObject:card];
  NSArray *chosenCards = [self findChosenCards];
  if ([self shouldCheckForMatch:chosenCards]) {
    [allCardsInMove addObjectsFromArray:chosenCards];
    int matchScore  = [card match:chosenCards];
    if (matchScore){
      [self handleMatchOfCards:allCardsInMove score:matchScore];
    }
    else{
      [self handleMissMatchOfCards:allCardsInMove];
    }
  }
  self.score -= COST_TO_CHOOSE;
  card.chosen = YES;
}

// Finds chosen cards to try to match to card.
- (NSArray *)findChosenCards {
  NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
  for (Card *card in self.cards) {
    if (card.isChosen && !card.isMatched) {
      [chosenCards addObject:card];
    }
  }
  return [chosenCards copy];
}

- (BOOL)shouldCheckForMatch:(NSArray *)chosenCards {
  return NO;
}

// Handles case of match - updates score of the game, history, and chosen cards states.
- (void)handleMatchOfCards:(NSArray *)chosenCards score:(NSUInteger)matchScore {
  NSInteger addedScore = matchScore * MATCH_BONUS;
  [self updateHistroyWithMove:MoveTypeMatch score:addedScore cards:chosenCards];
  self.score += addedScore;
  for (Card *chosenCard in chosenCards){
    chosenCard.matched = YES;
  }
}

// Handles case of missmatch - updates score of the game, histroy, and chosen cards states.
- (void)handleMissMatchOfCards:(NSArray *)chosenCards {
  [self updateHistroyWithMove:MoveTypeMismatch score:MISMATCH_PENALTY cards:chosenCards];
  self.score -= MISMATCH_PENALTY;
  for (Card *chosenCard in chosenCards) {
    chosenCard.chosen = NO;
  }
}

- (void)updateHistroyWithMove:(MoveType)moveType score:(NSInteger)score
                        cards:(NSArray *)chosenCards {
  CardGameMove *move = [[CardGameMove alloc] initWithType:moveType score:score
                                              chosenCards:chosenCards];
  [self.history addMove:move];
}

@end

NS_ASSUME_NONNULL_END
