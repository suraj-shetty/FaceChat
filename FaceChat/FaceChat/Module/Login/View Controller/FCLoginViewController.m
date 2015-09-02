//
//  ViewController.m
//  FaceChat
//
//  Created by Sourcebits on 30/08/15.
//  Copyright (c) 2015 glasslo. All rights reserved.
//

#import "FCLoginViewController.h"
#import "FCTileView.h"
#import "NSString+FCValidationCheck.h"
#import "NSArray+Shuffling.h"

static NSTimeInterval const kFlipAnimationDelay = 2.0f;

@interface FCLoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutletCollection(FCTileView) NSArray *tileViews;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) NSTimer *flipTimer;
@property (strong, nonatomic) NSArray *tilesToFlip;
@property (nonatomic) NSUInteger currentIndex;

- (IBAction)loginAction:(id)sender;
@end

@implementation FCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *images = @[[UIImage imageNamed:@"1.png"],
                        [UIImage imageNamed:@"2.png"],
                        [UIImage imageNamed:@"3.png"],
                        [UIImage imageNamed:@"4.png"],
                        [UIImage imageNamed:@"5.png"],
                        [UIImage imageNamed:@"6.png"]];
    
    [self.tileViews enumerateObjectsUsingBlock:^(FCTileView* aTileView, NSUInteger idx, BOOL *stop) {
        aTileView.images = images;
        aTileView.mode = FCFlipModeTriggered;
        [aTileView startAtIndex:idx];
    }];
    
    UIColor *borderColor = [UIColor colorWithRed:240/255.0f green:70/255.0f blue:93/255.0f alpha:1.0f];
    CGFloat buttonHeight = 30.0f;
    CGFloat cornerRadius = roundf(buttonHeight/2.0f);
    
    CALayer *signupButtonLayer = self.signUpButton.layer;
    signupButtonLayer.cornerRadius = cornerRadius;
    signupButtonLayer.borderColor = borderColor.CGColor;
    signupButtonLayer.borderWidth = 1.0f;
    self.signUpButton.clipsToBounds = YES;
    
    UITapGestureRecognizer *dismissTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    [self.view addGestureRecognizer:dismissTapGesture];
    
    self.currentIndex = 0;
    self.tilesToFlip = [[self tileViews] shuffledArray];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kFlipAnimationDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self flipTile];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (IBAction)loginAction:(id)sender {
    [self dismiss:nil];
    [self logIn];
}

#pragma mark - Dismiss Tap Gesture
-(void) dismiss:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.userNameField])
        [self.passwordField becomeFirstResponder];
    else
        [self loginAction:nil];
    return YES;
}

#pragma mark - Login
-(void) logIn {
    NSString *emailAddress = self.userNameField.text;
    NSString *password = self.passwordField.text;
    
    BOOL isValidEmail = [emailAddress isValidEmailAddress];
    if (isValidEmail == NO) {
        [self alertWithTitle:@"Invalid Email!" message:@"Please enter a valid email address"];
        return;
    }
    BOOL isValidPassword = [password isValidPassword];
    if (NO == isValidPassword) {
        [self alertWithTitle:@"Invalid Password!" message:@"Please enter a password of 8-16 characters"];
        return;
    }
    else
        [self alertWithTitle:@"Sign-in Success!" message:@"You have successfully logged-in to the app"];
}

#pragma mark - 
-(void) alertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [errorAlertController addAction:cancelAction];
    [self presentViewController:errorAlertController animated:YES completion:nil];
}

#pragma mark -
-(void) flipTile {
    __weak typeof(self) weakSelf = self;
    
    FCTileView *tileToFlip = self.tilesToFlip[self.currentIndex];
    [tileToFlip flip];
    self.currentIndex = (self.currentIndex + 1)%self.tilesToFlip.count;
    
    if (self.currentIndex == 0) {
        self.tilesToFlip = [[self.tileViews shuffledArray] copy];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kFlipAnimationDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf flipTile];
    });
}
@end
