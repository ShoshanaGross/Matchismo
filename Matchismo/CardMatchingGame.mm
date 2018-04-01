// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardMatchingGame.h"

#import "Card.h"
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()

// Score of the game.
@property (nonatomic, readwrite) NSInteger score;

// Deck of cards used for the game.
@property (nonatomic) Deck* deck;

@end

@implementation CardMatchingGame

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
    _cards = [cards copy];
    _deck = deck;
  }
  return self;
}

static const int kMissMatchPenalty = 2;
static const int kMatchBonus = 4;
static const int kCostToChoose = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
  Card *card = [self cardAtIndex:index];
  if (card.matched) {
    return;
  }
  if (card.isChosen) {
    card.chosen = NO;
    return;
  }
  NSArray *otherChosenCards = [self getOtherChosenCards];
  if ([self shouldCheckForMatch:[otherChosenCards arrayByAddingObject:card]]) {
    NSArray *allCardsInMove = [otherChosenCards arrayByAddingObject:card];
    int matchScore  = [card match:otherChosenCards];
    if (matchScore) {
      [self handleMatchOfCards:allCardsInMove score:matchScore];
    }
    else {
      [self handleMissMatchOfCards:allCardsInMove];
    }
  }
  self.score -= kCostToChoose;
  card.chosen = YES;
}

- (nullable Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSArray *)getOtherChosenCards {
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

- (void)handleMatchOfCards:(NSArray *)chosenCards score:(NSUInteger)matchScore {
  NSInteger addedScore = matchScore * kMatchBonus;
  self.score += addedScore;
  for (Card *chosenCard in chosenCards){
    chosenCard.matched = YES;
  }
}

- (void)handleMissMatchOfCards:(NSArray *)chosenCards {
  self.score -= kMissMatchPenalty;
  for (Card *chosenCard in chosenCards) {
    chosenCard.chosen = NO;
  }
}

-(void)removeCard:(Card *)card {
  NSMutableArray *cardsArray = [[NSMutableArray alloc] initWithArray:self.cards];
  [cardsArray removeObject:card];
  self.cards = cardsArray;
}

static const int kCostToAdd = 5;

- (void)addCardsFromDeck:(NSUInteger)cardsCount {
  NSMutableArray *cardsArray = [[NSMutableArray alloc] initWithArray:self.cards];
  for (int i = 0; i < cardsCount; i++) {
    Card *card = [self.deck drawRandomCard];
    if (card) {
      [cardsArray addObject:card];
    }
  }
  self.cards = cardsArray;
  self.score -= kCostToAdd;
}

@end

NS_ASSUME_NONNULL_END
