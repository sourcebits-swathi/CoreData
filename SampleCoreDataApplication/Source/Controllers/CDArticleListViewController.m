//
//  CDArticleListViewController.m
//  CoreDataTutorial
//
//  Created by Swathi Tata on 02/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import "CDArticleListViewController.h"
#import "CDWebEngine.h"
#import <Accounts/Accounts.h>

@interface CDArticleListViewController ()
{
    UITableViewCell *Cell;

}

@end

@implementation CDArticleListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

#pragma mark-
#pragma mark - Authenticate Button Action

- (IBAction)authenticateAndReterieveAndSaveIntoCoreDataButtonAction:(id)sender {
    
    [self authenticateUserAccount];

}

#pragma mark-
#pragma mark - Authenticate The User
- (void)authenticateUserAccount
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    NSLog(@"accounts %@",account);
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:
                                  ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType options:nil
                                  completion:^(BOOL granted, NSError *error)
     {
         if (error != NULL) {
             
             UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             
             [alertview performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
             
         }
         
         else if (granted == YES)
         {
             NSLog(@"permission granted");

             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             if (arrayOfAccounts.count == 0) {
                 
                 UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"No accounts are configured in device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 
                 [alertview performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
             }
             
             else
             {
             [[CDWebEngine sharedEngine]getArticlesFromTwitter:[arrayOfAccounts lastObject]];
             }
             
         }
         
     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
