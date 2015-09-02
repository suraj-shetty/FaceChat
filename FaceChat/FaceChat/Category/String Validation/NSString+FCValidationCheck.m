//
//  NSString+FCValidationCheck.m
//  FaceChat
//
//  Created by Sourcebits on 31/08/15.
//  Copyright (c) 2015 glasslo. All rights reserved.
//

#import "NSString+FCValidationCheck.h"

@implementation NSString (FCValidationCheck)

-(BOOL) isValidEmailAddress {
    /*
     For reference
     http://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios
     */
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL) isValidPassword {
    NSUInteger length = self.length;
    if (length >= 8 && length <= 16) {
        return YES;
    }
    return NO;
}
@end
