// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shoshana Gross.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardView

#pragma mark - Initialization

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setup];
  }
  return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect{
  [super drawRect:rect];
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:[self cornerRadius]];
  [roundedRect addClip];

  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
}

#define CORNER_RADIUS 12.0

- (CGFloat)cornerRadius {
  return CORNER_RADIUS * [self cornerScaleFactor];
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

@end

NS_ASSUME_NONNULL_END
