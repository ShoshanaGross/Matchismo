// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "SetViewController.h"

#import "CardGameBehavior.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetMatchingGame.h"
#import "Grid.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetViewController ()

// Instance of the game.
@property (nonatomic, strong) CardMatchingGame *game;

// Array of all the card views in the game.
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *cardsViews;

// Button to add cards to the game.
@property (weak, nonatomic) IBOutlet UIButton *addCardsButton;

// Array of matched cards.
@property (nonatomic) NSArray <SetCard *> *matchedCards;

@end

@implementation SetViewController

# pragma mark - CardGameViewController

- (nullable Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (nullable CardMatchingGame *)createGameWithCardCount:(NSUInteger)count deck:(Deck *)deck{
  return [[SetMatchingGame alloc] initWithCardCount:count deck:deck];
}

- (nullable CardView *)createViewFromCard:(Card *)card frame:(CGRect)frame {
  SetCard *setCard = (SetCard *)card;
  SetCardView *setCardView = [[SetCardView alloc] initWithFrame:frame number:setCard.number
                                                          color:setCard.color
                                                         symbol:setCard.symbol
                                                        shading:setCard.shading];
  return setCardView;
}

- (IBAction)pinch:(UISwipeGestureRecognizer *)sender{
  [super pinch:sender];
  self.addCardsButton.enabled = NO;
}

-(void)tap:(UIPanGestureRecognizer *)sender{
  [super tap:sender];
  self.addCardsButton.enabled = YES;
}

- (IBAction)touchDealButton:(UIButton *)sender{
  [super touchDealButton:sender];
  self.addCardsButton.enabled = YES;
}
- (void)updateUI {
  [super updateUI];
  for (CardView *cardView in self.cardsViews) {
    Card *card = [self.game cardAtIndex:[self.cardsViews indexOfObject:cardView]];
    cardView.alpha = card.isChosen ? 0.5 : 1;
    if (card.isMatched) {
      [self  addCardToMatched:card];
    }
  }
  if (self.matchedCards.count == 3){
    [self removeMatched];
  }
}

#pragma mark - Set game logic

- (void)addCardToMatched:(Card *)card {
  NSMutableArray < SetCard *> *currentMatched = [[NSMutableArray alloc]
                                                 initWithArray:self.matchedCards];
  [currentMatched addObject:(SetCard *)card];
  self.matchedCards = currentMatched;
}

- (void)removeMatched {
  for (Card *card in self.matchedCards){
    NSUInteger index = [self.game.cards indexOfObject:card];
    SetCardView *view = [self.cardsViews objectAtIndex:index];
    [self animateRemovalOfCardView:view];
    [self removeCardFromCardsViews:view];
    [self.game removeCard:card];
  }
  self.matchedCards = [[NSArray alloc] init];
  [self.view setNeedsLayout];
}

- (void)removeCardFromCardsViews:(CardView *)cardView {
  NSMutableArray < CardView *> *cardsViews = [[NSMutableArray alloc]
                                                 initWithArray:self.cardsViews];
  [cardsViews removeObject:cardView];
  self.cardsViews = cardsViews;
}

- (void)animateRemovalOfCardView:(CardView *)cardView {
  [UIView transitionWithView:cardView duration:1.0
                     options:UIViewAnimationOptionOverrideInheritedDuration
                  animations:^{
                    cardView.alpha = 1.0;
                    cardView.center = CGPointMake(self.view.bounds.size.width,
                                                  self.view.bounds.size.height);
                  }
                  completion:^(BOOL finished){
                    if (finished){
                      [cardView removeFromSuperview];
                    }
                  }];
}

static const int kNumberOfCardsToAdd = 3;

- (IBAction)addCards:(UIButton *)sender {
  NSUInteger previousCardsCount = self.game.cards.count;
  [self.game addCardsFromDeck:kNumberOfCardsToAdd];
  if (previousCardsCount == self.game.cards.count) {
    sender.enabled = NO;
    return;
  }
  [self addCardsViews];
  [self updateUI];
  [self.view setNeedsLayout];

}

- (void)addCardsViews {
  for (int i = kNumberOfCardsToAdd; i > 0 ; i--) {
    NSUInteger index = self.game.cards.count - i;
    SetCard *setCard = self.game.cards[index];
    CGRect defaultFrame = CGRectMake(-100, -100, 10, 10);
    SetCardView *cardView = [[SetCardView alloc] initWithFrame:defaultFrame number:setCard.number
                                                         color:setCard.color
                                                        symbol:setCard.symbol
                                                       shading:setCard.shading];
    [self setupNewCardView:cardView atIndex:index];
  }
}

@end

NS_ASSUME_NONNULL_END
