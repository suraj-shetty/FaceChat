//
//  FCTileView.m
//  FaceChat
//
//  Created by Sourcebits on 30/08/15.
//  Copyright (c) 2015 glasslo. All rights reserved.
//

#import "FCTileView.h"

static CGFloat const kAnimattionDuration = 1.0f;

@interface FCTileView ()
@property (nonatomic, weak) UIImageView *tileImageView;
@property (nonatomic) CGFloat animationDelay;
@property (nonatomic) NSUInteger index;
@end

@implementation FCTileView

-(void) awakeFromNib {
    UIImageView *tileImageView = [UIImageView new];
    [self addSubview:tileImageView];
    
    self.tileImageView = tileImageView;
    [self layoutIfNeeded];
    self.backgroundColor = [UIColor clearColor];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    [self.tileImageView setFrame:self.bounds];
}

-(void) animateFlip {
    __weak typeof(self) weakSelf = self;
    weakSelf.index = (weakSelf.index +1)%(weakSelf.images.count);
    UIImage *nextImage = weakSelf.images[weakSelf.index];
    
    [UIView transitionWithView:self.tileImageView duration:kAnimattionDuration options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        weakSelf.tileImageView.image = nextImage;
    } completion:^(BOOL finished) {
        if (finished == YES && weakSelf.mode == FCFlipModeAutomatic) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(weakSelf.animationDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf animateFlip];
            });
        }
    }];
}

-(void) startAtIndex:(NSInteger)index {
    self.index = index;
    if (self.images.count <= index) {
        self.index = 0;
    }
    NSInteger delay = index;
    if (self.images.count > 0) {
        UIImage *currentImage = self.images[self.index];
        self.tileImageView.image = currentImage;
        
        if (self.mode == FCFlipModeAutomatic) {
            self.animationDelay = self.images.count + 2;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                         (int64_t)(delay * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                               [self animateFlip];
                           });
        }
    }
}

#pragma mark - 
-(void) flip {
    [self animateFlip];
}
@end
