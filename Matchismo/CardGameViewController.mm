// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardGameViewController.h"

#import "CardView.h"
#import "CardMatchingGame.h"
#import "Deck.h"
#import "Grid.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController ()

// Instance of the game.
@property (nonatomic, strong) CardMatchingGame *game;

// Array of all the card views in the game.
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *cardsViews;

// Label to present score to the user.
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

// Button to re-deal the cards.
@property (weak, nonatomic) IBOutlet UIButton *dealButton;

// View that defines the boundary for the cards in the game.
@property (weak, nonatomic) IBOutlet UIView *boundaryAreaView;

// Grid to place the cards views in.
@property (nonatomic) Grid *grid;

/// Specifies if the \c cardsViews are pinched.
@property (readwrite, nonatomic) BOOL isPinched;

// Animator for the game.
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation CardGameViewController

#pragma mark - Gesture handling

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
  NSUInteger cardViewIndex = [self.cardsViews indexOfObject:sender.view];
  CardView *view = self.cardsViews[cardViewIndex];
  [self.game chooseCardAtIndex:cardViewIndex];
  [UIView transitionWithView:view duration:0.2 options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:nil
                  completion:nil];
  [self updateUI];
}

- (IBAction)pinch:(UISwipeGestureRecognizer *)sender {
  CGPoint center = self.view.center;
  for (CardView *cardView in self.cardsViews){
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:cardView
                                                             snapToPoint:center];
    snapBehaviour.damping = 1;
    [self.animator addBehavior:snapBehaviour];
  }
  [self addGestureRecognitionToLastCard];
  self.isPinched = YES;
}

- (void)addGestureRecognitionToLastCard {
  CardView *lastCard = [self.cardsViews lastObject];
  [lastCard addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self action:@selector(tap:)]];
  [lastCard addGestureRecognizer:[[UIPanGestureRecognizer alloc]
                                  initWithTarget:self action:@selector(pan:)]];
}

-(void)pan:(UIPanGestureRecognizer *)sender{
  CGPoint touchLocation = [sender locationInView:self.boundaryAreaView];
  for (CardView *cardView in self.cardsViews){
    cardView.center = touchLocation;
  }
}

-(void)tap:(UIPanGestureRecognizer *)sender{
  [self removeGestureRecognition];
  self.isPinched = NO;
  [self.view setNeedsLayout];
}

- (void)removeGestureRecognition {
  [self.animator removeAllBehaviors];
  CardView *lastCard = [self.cardsViews lastObject];
  while (lastCard.gestureRecognizers.count) {
    [lastCard removeGestureRecognizer:[lastCard.gestureRecognizers objectAtIndex:0]];
  }
}

- (IBAction)touchDealButton:(UIButton *)sender {
  [self setupNewGame];
}

# pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  self.boundaryAreaView.backgroundColor = nil;
  [self.view addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                              initWithTarget:self action:@selector(pinch:)]];
  [self setupNewGame];
}

- (void)viewDidLayoutSubviews{
  [super viewDidLayoutSubviews];
  if (!self.isPinched){
    self.grid = [self createGridWithSize:self.boundaryAreaView.frame.size
                           MinNumOfCells:self.game.cards.count];
    [self updateCardsViews];
  }
}

# pragma mark - Game logic

const static int kInialNumberOfCards = 12;

- (void)setupNewGame {
  self.game = [self createGameWithCardCount:kInialNumberOfCards deck:[self createDeck]];
  self.grid = [self createGridWithSize:self.boundaryAreaView.frame.size
                         MinNumOfCells:self.game.cards.count];
  [self createCardsViews];
}

- (nullable CardMatchingGame *)createGameWithCardCount:(NSUInteger)count deck:(Deck *)deck {
  return nil;
}

- (nullable Deck *)createDeck {
  return nil;
}

const static float kCellAspectRatio = 3 / 2;

- (Grid *)createGridWithSize:(CGSize)size MinNumOfCells:(NSUInteger)num {
  Grid *grid = [[Grid alloc] init];
  grid.size = size;
  grid.cellAspectRatio = kCellAspectRatio;
  grid.minimumNumberOfCells = num;
  return grid;
}

- (void)createCardsViews {
  [self removeAllCardsViews];
  self.cardsViews = [[NSMutableArray alloc] init];
  for (Card *card in self.game.cards){
    NSUInteger index = [self.game.cards indexOfObject:card];
    CGRect defaultFrame = CGRectMake(-100, -100, 10, 10);
    CardView *cardView = [self createViewFromCard:card frame:defaultFrame];
    [self setupNewCardView:cardView atIndex:index];
  }
  [self updateUI];
}

- (void)removeAllCardsViews {
  for (CardView *view in self.cardsViews){
    [view removeFromSuperview];
  }
}

- (nullable CardView *)createViewFromCard:(Card *)card frame:(CGRect)frame {
  return nil;
}

- (void)updateUI {
  self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (void)setupNewCardView:(CardView *)cardView atIndex:(NSUInteger)index{
  [cardView addGestureRecognizer:[[UISwipeGestureRecognizer alloc]
                              initWithTarget:self action:@selector(swipe:)]];
  self.cardsViews = [self.cardsViews arrayByAddingObject:cardView];
  [self.boundaryAreaView addSubview:cardView];
  [self animateCardEntrance:cardView atIndex:index];
}

- (void)updateCardsViews {
  for(CardView *cardView in self.cardsViews){
    NSUInteger index = [self.cardsViews indexOfObject:cardView];
    [self animateCardEntrance:cardView atIndex:index];
  }  
}

- (void)animateCardEntrance:(CardView *)cardView atIndex:(NSUInteger)index {
  [UIView transitionWithView:cardView duration:1.0
                     options:UIViewAnimationOptionOverrideInheritedDuration
                  animations:^{cardView.frame = [self.grid frameAtIndex:index];}
                  completion:nil];
}

@end

NS_ASSUME_NONNULL_END

