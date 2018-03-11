//
//  ViewController.m
//  Matchismo
//
//  Created by Shoshana Gross on 05/03/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLable;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[self createPlayingCardDeck]
                                                            withMode:self.gameModeControl.selectedSegmentIndex];
    return _game;
}

- (Deck *)createPlayingCardDeck
{
    PlayingCardDeck *playingCardDeck = [[PlayingCardDeck alloc] init];
    [playingCardDeck createDeck];
    return playingCardDeck;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    self.gameModeControl.enabled = NO;
}


- (IBAction)touchDealButton:(UIButton *)sender

{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createPlayingCardDeck]
                                                   withMode:self.gameModeControl.selectedSegmentIndex];
    [self updateUI];
    self.gameModeControl.enabled = YES;
    
}

- (IBAction)changeSegment:(id)sender
{
    NSLog(@"game mode control %ld", self.gameModeControl.selectedSegmentIndex);
    self.game.mode = self.gameModeControl.selectedSegmentIndex;
    
}

- (void)updateMoveDescription
{
    self.descriptionLable.text =  self.game.moveDescription;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [self updateMoveDescription];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen? @"cardfront" : @"cardback"];
}
@end
