// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardGameViewController.h"

#import "CardMatchingGame.h"
#import "Deck.h"
#import "HistoryViewController.h"

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

@end

@implementation CardGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
  if ([segue.identifier isEqualToString:@"Show History"]) {
    if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
      HistoryViewController *historyView = (HistoryViewController *)segue.destinationViewController;
      historyView.history = self.game.history;
    }
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (CardMatchingGame *)game {
  if (!_game) _game = [self createGameWithCardCount:self.cardButtons.count deck:[self createDeck]];
  return _game;
}

- (CardMatchingGame *) createGameWithCardCount:(NSUInteger)count deck:(Deck *)deck {
  return nil;
}

- (Deck *)createDeck {
  return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

- (IBAction)touchDealButton:(UIButton *)sender {
  self.game = [self createGameWithCardCount:self.cardButtons.count deck:[self createDeck]];
  [self updateUI];
}


- (void)updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setAttributedTitle: [self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
    [cardButton setBackgroundColor:[self backgroundColorForCard:card]];
    cardButton.enabled = !card.isMatched;
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
  }
}

- (NSAttributedString *)titleForCard:(Card *)card{
  return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
  return nil;
}

-(UIColor *)backgroundColorForCard:(Card *)card {
  return nil;
}

@end

NS_ASSUME_NONNULL_END
