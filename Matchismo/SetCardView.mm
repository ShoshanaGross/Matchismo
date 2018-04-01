// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView ()

/// Number of the card.
@property (nonatomic) NSInteger number;

/// Color of the card.
@property (nonatomic) SetCardColor color;

/// Symbol of the card.
@property (nonatomic) SetCardSymbol symbol;

/// Shading of the card.
@property (nonatomic) SetCardShading shading;

@end

@implementation SetCardView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame number:(NSUInteger)number color:(SetCardColor)color
                       symbol:(SetCardSymbol)symbol
                      shading:(SetCardShading)shading {
  if (self =  [super initWithFrame:frame]) {
    _number = number;
    _color = color;
    _symbol = symbol;
    _shading = shading;
  }
  return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  UIImage *cardImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@%@",
                       [self colorAsString], [self shadingAsString], [self symbolAsString]]];
  
  CGFloat originX = self.bounds.origin.x;
  CGFloat originY = self.bounds.origin.y;
  CGFloat width = self.bounds.size.width;
  CGFloat height = self.bounds.size.height;
  
  CGRect top = CGRectMake(originX, originY, width, height / 3 );
  CGRect bottom = CGRectMake(originX, originY + height * 2 / 3 , width, height / 3);
  CGRect middle = CGRectMake(originX, originY + height / 3, width, height / 3);
  
  CGRect topHalf = CGRectMake(originX, originY + height / 5, width, height / 3);
  CGRect bottomHalf = CGRectMake(originX, originY + height / 2, width, height / 3);

  switch (self.number) {
    case 1:
      [cardImage drawInRect:middle];
      break;
    case 2:
      [cardImage drawInRect:topHalf];
      [cardImage drawInRect:bottomHalf];
      break;
    case 3:
      [cardImage drawInRect:middle];
      [cardImage drawInRect:top];
      [cardImage drawInRect:bottom];
  }
}

- (NSString *)symbolAsString {
  return @[@"Diamond", @"Squiggle", @"Oval"][self.symbol];
}

- (NSString *)colorAsString {
  return @[@"Green", @"Purple", @"Red"][self.color];
}

- (NSString *)shadingAsString {
  return @[@"Solid", @"Stripped", @"Open"][self.shading];
}
@end

NS_ASSUME_NONNULL_END
