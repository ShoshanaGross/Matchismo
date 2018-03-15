// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "HistoryViewController.h"

#import "CardGameHistory.h"
#import "CardGameMove.h"
#import "Card.h"
#import "SetViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController()

// Text view to presnt the game history.
@property (weak, nonatomic) IBOutlet UITextView *historyText;

@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)updateUI {
  NSMutableAttributedString *historyData = [[NSMutableAttributedString alloc] init];
  for (CardGameMove *move in self.history.moves) {
    [historyData appendAttributedString:[self getMoveData:move]];
    [historyData appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
  }
  self.historyText.attributedText = historyData;
}

- (NSAttributedString *)getMoveData:(CardGameMove *)move {
  NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] init];
  for (Card *card in move.chosenCards) {
    if ([card.contents isKindOfClass:[NSAttributedString class]]) {
      [contents appendAttributedString:(NSAttributedString *) card.contents];
    }
    else {
      [contents appendAttributedString: [[NSAttributedString alloc] initWithString:card.contents]];
    }
    [contents appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
  }
  NSString *moveDescription = @"";
  if (move.moveType == MoveTypeChoise) {
    moveDescription = @" was chosen.";
  }
  else if (move.moveType == MoveTypeMatch) {
    moveDescription = [NSString stringWithFormat:@"matched for %lu points!",
                       (unsigned long)move.score];
  }
  else if (move.moveType == MoveTypeMismatch) {
    moveDescription = [NSString stringWithFormat:@" don't match! %lu points penalty!",
                       (unsigned long)move.score];
  }
  [contents appendAttributedString:[[NSAttributedString alloc] initWithString:moveDescription]];
  return contents;
}

@end

NS_ASSUME_NONNULL_END
