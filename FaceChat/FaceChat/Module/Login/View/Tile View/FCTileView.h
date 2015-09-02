//
//  FCTileView.h
//  FaceChat
//
//  Created by Sourcebits on 30/08/15.
//  Copyright (c) 2015 glasslo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FCFlipMode) {
    FCFlipModeAutomatic = 1, /*Internal timer based*/
    FCFlipModeTriggered = 2 /* By calling 'flip' selector */
};
@interface FCTileView : UIView
@property (nonatomic, strong) NSArray *images;
@property (nonatomic) FCFlipMode mode;

-(void) startAtIndex:(NSInteger)index;
-(void) flip;
@end
