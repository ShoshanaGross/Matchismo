// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "PlayingCardGameViewController.h"

#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGame.h"
#import "PlayingCardView.h"
#import "Grid.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardGameViewController ()

// Instance of the game.
@property (nonatomic, strong) CardMatchingGame *game;

// Array of all the card views in the game.
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *cardsViews;

@end

@implementation PlayingCardGameViewController

# pragma mark - CardGameViewController

- (nullable Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (nullable CardMatchingGame *)createGameWithCardCount:(NSUInteger)count deck:(Deck *)deck {
  return [[PlayingCardMatchingGame alloc] initWithCardCount:count deck:deck];
}

- (nullable CardView *)createViewFromCard:(Card *)card frame:(CGRect)frame{
  PlayingCard *playingCard = (PlayingCard *)card;
  PlayingCardView *playingCardView = [[PlayingCardView alloc] initWithFrame:frame
                                                                       rank:playingCard.rank
                                                                       suit:playingCard.suit];
  return playingCardView;
}

- (void)updateUI {
  [super updateUI];
  for (PlayingCardView *cardView in self.cardsViews){
    Card *card = [self.game cardAtIndex:[self.cardsViews indexOfObject:cardView]];
    cardView.faceUp = card.isChosen;
    cardView.matched = card.isMatched;
    cardView.userInteractionEnabled = card.isMatched ? NO : YES;
  }
}

@end

NS_ASSUME_NONNULL_END
