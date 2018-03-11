// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()

// Score of the game.
@property (nonatomic, readwrite) NSInteger score;

/// Description of last move in the game.
@property (nonatomic, strong, readwrite) NSString *moveDescription;

// Array of cards that participates in the game.
@property (nonatomic, strong) NSArray *cards;

@end

@implementation CardMatchingGame

- (NSArray *)cards {
  if (!_cards) _cards = [[NSArray alloc] init];
  return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck {
  return [self initWithCardCount:count deck:deck mode:GameModeTwoCardsMatch];
}

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck mode:(GameMode)mode {
  
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
    _moveDescription = [[NSString alloc] init];
    _mode = mode;
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
    self.moveDescription = [card contents];
    NSArray *chosenCards = [self findChosenCards];
    if ([self shouldCheckForMatch:chosenCards]) {
        int matchScore  = [card match:chosenCards];
        if (matchScore){
            [self handleMatchOfCard:card chosenCards:chosenCards score:matchScore];
        }
        else{
            [self handleMissMatchOfCard:card chosenCards:chosenCards];
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
      if (self.mode == 0) {
        break;
      }
    }
  }
  return [chosenCards copy];
}

- (BOOL)shouldCheckForMatch:(NSArray *)chosenCards {
  if ((self.mode == 0 && chosenCards.count == 1) || (self.mode == 1 && chosenCards.count == 2)) {
    return YES;
  }
  return NO;
}

// Handles case of match - updates score of the game, updates move description and update chosen
// cards state to be matched.
- (void)handleMatchOfCard:(Card *)card chosenCards:(NSArray *)cardsToMatch
                    score:(NSUInteger)matchScore {
  NSString *cardsContent = [NSString stringWithFormat:@"%@ ", card.contents];
  self.score += matchScore * MATCH_BONUS;
  for (Card *chosenCard in cardsToMatch){
    chosenCard.matched = YES;
    cardsContent = [cardsContent stringByAppendingFormat:@"%@ ", chosenCard.contents];
  }
  card.matched = YES;
  self.moveDescription = [NSString stringWithFormat:@"Matched %@ for %lu points",
                          cardsContent, (matchScore * MATCH_BONUS)];
}

// Handles case of missmatch - updates score of the game, updates move description and updates
// chosen cards to be unchose, exept card which is still chosen.
- (void)handleMissMatchOfCard:(Card *)card chosenCards:(NSArray *)chosenCards {
  NSString *cardsContent = [NSString stringWithFormat:@"%@ ", card.contents];
  self.score -= MISMATCH_PENALTY;
  for (Card *chosenCard in chosenCards) {
    chosenCard.chosen = NO;
    cardsContent = [cardsContent stringByAppendingFormat:@"%@ ", chosenCard.contents];
    
  }
  self.moveDescription = [NSString stringWithFormat:@"%@ don't match! %d points penalty!",
                          cardsContent, MISMATCH_PENALTY];
}

@end

NS_ASSUME_NONNULL_END
