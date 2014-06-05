//
//  CDWebEngine.h
//  CoreDataTutorial
//
//  Created by Swathi Tata on 02/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

@interface CDWebEngine : NSObject

+(CDWebEngine *)sharedEngine;
-(void)getArticlesFromTwitter:(ACAccount *)lobjTwitterAccount;
@end
