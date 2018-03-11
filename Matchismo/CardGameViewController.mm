// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardGameViewController.h"

#import "CardMatchingGame.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController ()

// Instance of the game.
@property (nonatomic, strong) CardMatchingGame *game;

// Collection of card buttons.
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// Label to present score to the user.
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

// Button to re-deal the cards.
@property (weak, nonatomic) IBOutlet UIButton *dealButton;

// Segment control to decide between 2 cards match and 3 cards match.
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;

// Lable to describe current move to the user.
@property (weak, nonatomic) IBOutlet UILabel *descriptionLable;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
  GameMode gameMode = [self chosenGameMode:self.gameModeControl.selectedSegmentIndex];
  if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                             deck:[self createDeck]
                                                             mode:gameMode];
  return _game;
}

- (GameMode)chosenGameMode:(NSInteger)selecteSegment {
  if (selecteSegment == 1) {
    return GameModeThreeCardsMatch;
  }
  return GameModeTwoCardsMatch;
}

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
  self.gameModeControl.enabled = NO;
}

- (IBAction)touchDealButton:(UIButton *)sender {
  GameMode gameMode = [self chosenGameMode:self.gameModeControl.selectedSegmentIndex];
  self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                     deck:[self createDeck]
                                                     mode:gameMode];
  [self updateUI];
  self.gameModeControl.enabled = YES;
}

- (IBAction)changeSegment:(id)sender {
  self.game.mode = [self chosenGameMode:self.gameModeControl.selectedSegmentIndex];
}

- (void)updateMoveDescription {
  self.descriptionLable.text =  self.game.moveDescription;
}

- (void)updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [self updateMoveDescription];
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
  }
}

- (NSString *)titleForCard:(Card *)card {
  return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen? @"cardfront" : @"cardback"];
}

@end

NS_ASSUME_NONNULL_END
