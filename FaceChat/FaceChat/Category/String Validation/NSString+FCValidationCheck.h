//
//  NSString+FCValidationCheck.h
//  FaceChat
//
//  Created by Sourcebits on 31/08/15.
//  Copyright (c) 2015 glasslo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FCValidationCheck)

-(BOOL) isValidEmailAddress;
-(BOOL) isValidPassword;
@end
