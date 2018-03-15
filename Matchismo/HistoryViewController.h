// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CardGameHistory;

/// Controller for the history of the game view.
@interface HistoryViewController : UIViewController

/// Represents the histroy of the game.
@property (nonatomic, strong) CardGameHistory *history;

@end

NS_ASSUME_NONNULL_END
