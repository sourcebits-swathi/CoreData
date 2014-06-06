//
//  CDWebEngine.m
//  CoreDataTutorial
//
//  Created by Swathi Tata on 02/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import "CDWebEngine.h"
#import "CDDatabaseManager.h"
#import "CDTweetDetails.h"
#import "CDTweetUserDetails.h"
#import <Social/Social.h>

@interface CDWebEngine()
{
    ACAccount *twitterAccount;
    
}
@property (nonatomic,retain)  NSMutableArray *completeTweetDetails;
@property (nonatomic,retain)  NSMutableDictionary *followersDetails;
@property (nonatomic,retain) NSMutableArray *tweetDataToDatabase;
@property (nonatomic,retain) NSMutableArray *tweetUserDataToDatabase;
@property (nonatomic,retain) NSMutableArray *tweetUserfollowersDataToDatabase;

@end
@implementation CDWebEngine
@synthesize completeTweetDetails;
@synthesize tweetDataToDatabase;

+(CDWebEngine *)sharedEngine
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[super alloc] init];
    });
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
   
        self.tweetDataToDatabase = [NSMutableArray array];
        self.tweetUserDataToDatabase = [NSMutableArray array];
        self.tweetUserfollowersDataToDatabase = [NSMutableArray array];
    }
    return self;
}

#pragma mark-
#pragma mark - Get Followers 

-(void)getfollowersFromTwitter:(ACAccount *)lobjTwitterAccount
{
    twitterAccount = lobjTwitterAccount;
    
    NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/followers/list.json"];
    
    SLRequest *followersGetRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:nil];
    
    followersGetRequest.account = lobjTwitterAccount;
    
    [followersGetRequest performRequestWithHandler:^(NSData *responseData,
                                                     NSHTTPURLResponse *urlResponse, NSError *error)
    {
    
        NSError *errorInJson;
        
        if (error == nil) {
            
            self.followersDetails = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&errorInJson];
            NSLog(@"followers %@",self.followersDetails);
            
            NSArray *users = [self.followersDetails objectForKey:@"users"];
            
            NSLog(@"users %@",users);
            
            for (NSDictionary *article in users) {
                
                //Tweet User Details
                CDTweetUserDetails *tweetUserDetail = [[CDTweetUserDetails alloc]init];
                tweetUserDetail.contributors_enabled = (BOOL)[article valueForKeyPath:@"user.contributors_enabled"];
                tweetUserDetail.created_at = [article valueForKeyPath:@"user.created_at"];
                tweetUserDetail.default_profile = (BOOL)[article valueForKeyPath:@"user.default_profile"];
                tweetUserDetail.default_profile_image = (BOOL)[article valueForKeyPath:@"user.default_profile_image"];
                tweetUserDetail.description_tweet = [article valueForKeyPath:@"user.description_tweet"];
                tweetUserDetail.favourites_count = [article valueForKeyPath:@"user.favourites_count"];
                tweetUserDetail.follow_request_sent = (BOOL)[article valueForKeyPath:@"user.follow_request_sent"];
                tweetUserDetail.followers_count = [article valueForKeyPath:@"user.followers_count"];
                tweetUserDetail.friends_count = [article valueForKeyPath:@"user.friends_count"];
                tweetUserDetail.following = (BOOL)[article valueForKeyPath:@"user.following"];
                tweetUserDetail.geo_enabled = (BOOL)[article valueForKeyPath:@"user.geo_enabled"];
                tweetUserDetail.userid = [article valueForKeyPath:@"user.userid"];
                tweetUserDetail.userid_str = [article valueForKeyPath:@"user.userid_str"];
                tweetUserDetail.is_translator = (BOOL)[article valueForKeyPath:@"user.is_translator"];
                tweetUserDetail.lang = [article valueForKeyPath:@"user.lang"];
                tweetUserDetail.listed_count = [NSString stringWithFormat:@"%@",[article valueForKeyPath:@"user.listed_count"]];
                tweetUserDetail.location = [article valueForKeyPath:@"user.location"];
                tweetUserDetail.name = [article valueForKeyPath:@"user.name"];
                tweetUserDetail.notifications = (BOOL)[article valueForKeyPath:@"user.notifications"];
                tweetUserDetail.profile_background_color = [article valueForKeyPath:@"user.profile_background_color"];
                tweetUserDetail.profile_background_image_url = [article valueForKeyPath:@"user.profile_background_image_url"];
                tweetUserDetail.location = [article valueForKeyPath:@"user.location"];
                tweetUserDetail.name = [article valueForKeyPath:@"user.name"];
                tweetUserDetail.notifications = (BOOL)[article valueForKeyPath:@"user.notifications"];
                tweetUserDetail.profile_background_image_url = [article valueForKeyPath:@"user.profile_background_image_url"];
                tweetUserDetail.profile_background_image_url_https = [article valueForKeyPath:@"user.profile_background_image_url_https"];
                tweetUserDetail.profile_background_tile = (BOOL)[article valueForKeyPath:@"user.profile_background_tile"];
                tweetUserDetail.profile_image_url = [article valueForKeyPath:@"user.profile_image_url"];
                tweetUserDetail.profile_background_color = [article valueForKeyPath:@"user.profile_background_color"];
                tweetUserDetail.profile_link_color = [article valueForKeyPath:@"user.profile_link_color"];
                tweetUserDetail.profile_sidebar_border_color = [article valueForKeyPath:@"user.profile_sidebar_border_color"];
                tweetUserDetail.profile_sidebar_fill_color = [article valueForKeyPath:@"user.profile_sidebar_fill_color"];
                tweetUserDetail.profile_text_color = [article valueForKeyPath:@"user.profile_text_color"];
                tweetUserDetail.profile_text_color = [article valueForKeyPath:@"user.profile_text_color"];
                tweetUserDetail.profile_use_background_image = (BOOL)[article valueForKeyPath:@"user.profile_use_background_image"];
                tweetUserDetail.protected_user = [article valueForKeyPath:@"user.protected_user"];
                tweetUserDetail.screen_name = [article valueForKeyPath:@"user.screen_name"];
                tweetUserDetail.statuses_count = [NSString stringWithFormat:@"%@",[article valueForKeyPath:@"user.statuses_count"]];
                tweetUserDetail.time_zone = [article valueForKeyPath:@"user.time_zone"];
                tweetUserDetail.url = [article valueForKeyPath:@"user.url"];
                tweetUserDetail.utc_offset = [NSString stringWithFormat:@"%@",[article valueForKeyPath:@"user.utc_offset"]];
                tweetUserDetail.verified = (BOOL)[article valueForKeyPath:@"user.verified"];
                [self.tweetUserfollowersDataToDatabase addObject:tweetUserDetail];
                
            }
            
            [[CDDatabaseManager databaseManager]savingFollowerDeatails:self.tweetUserfollowersDataToDatabase];
        }
        
      
    
    }];
    
    
}

#pragma mark -
#pragma mark - Get Tweets And ReTweets

-(void)getArticlesFromTwitter:(ACAccount *)lobjTwitterAccount;
{

    twitterAccount = lobjTwitterAccount;
    
    NSURL *requestURL = [NSURL
                         URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
    
//    NSDictionary *parameters = @{@"count": @"10"};
    
    SLRequest *getRequest = [SLRequest
                             requestForServiceType:SLServiceTypeTwitter
                             requestMethod:SLRequestMethodGET
                             URL:requestURL parameters:nil];
    
    getRequest.account = twitterAccount;
    
    [getRequest performRequestWithHandler:^(NSData *responseData,
                                            NSHTTPURLResponse *urlResponse, NSError *error)
     {
         NSError *errorInJson;
         
         self.completeTweetDetails = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&errorInJson];
         
         NSLog(@"articles %@",self.completeTweetDetails);
        
         
         if (self.completeTweetDetails.count != 0)
         {
             
             for (NSDictionary *article in self.completeTweetDetails) {
                 
                 
                 CDTweetDetails *tweetDetails = [[CDTweetDetails alloc]init];
                 if ([article valueForKey:@"contributors"] == (NSString *)[NSNull null])
                 {
                      tweetDetails.contributors = @"";
                 }
                 else
                 tweetDetails.contributors = [article valueForKey:@"contributors"];
                 if ([article valueForKey:@"coordinates"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.coordinates = @"";
                 }
                 else
                 tweetDetails.coordinates = [article valueForKey:@"coordinates"];
                 if ([article valueForKey:@"created_at"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.created_at = @"";
                 }
                 else
                 tweetDetails.created_at = [article valueForKey:@"created_at"];
                 if ([article valueForKey:@"favorite_count"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.favorite_count = @"";
                 }
                 else
                 tweetDetails.favorite_count = [NSString stringWithFormat:@"%@",[article valueForKey:@"favorite_count"]];
                 if ([article valueForKey:@"favorited"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.favorited = @"";
                 }
                 else
                 tweetDetails.favorited = [NSString stringWithFormat:@"%@",[article valueForKey:@"favorited"]];
                 if ([article valueForKey:@"geo"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.geo = @"";
                 }
                 else
                 tweetDetails.geo = [article valueForKey:@"geo"];
                 if ([article valueForKey:@"id"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.idofTweet = @"";
                 }
                 else
                 tweetDetails.idofTweet = [article valueForKey:@"id"];
                 if ([article valueForKey:@"id_str"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.id_str = @"";
                 }
                 else
                 tweetDetails.id_str = [article valueForKey:@"id_str"];
                 if ([article valueForKey:@"in_reply_to_screen_name"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.in_reply_to_screen_name = @"";
                 }
                 else
                 tweetDetails.in_reply_to_screen_name = [article valueForKey:@"in_reply_to_screen_name"];
                 if ([article valueForKey:@"in_reply_to_status_id"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.in_reply_to_status_id = @"";
                 }
                 else
                 tweetDetails.in_reply_to_status_id = [NSString stringWithFormat:@"%@",[article valueForKey:@"in_reply_to_status_id"]];
                 if ([article valueForKey:@"in_reply_to_status_id_str"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.in_reply_to_status_id_str = @"";
                 }
                 else
                 tweetDetails.in_reply_to_status_id_str = [article valueForKey:@"in_reply_to_status_id_str"];
                 if ([article valueForKey:@"in_reply_to_user_id"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.in_reply_to_user_id = @"";
                 }
                 else
                 tweetDetails.in_reply_to_user_id = [NSString stringWithFormat:@"%@",[article valueForKey:@"in_reply_to_user_id"]];
                 if ([article valueForKey:@"in_reply_to_user_id_str"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.in_reply_to_user_id_str = @"";
                 }
                 else
                 tweetDetails.in_reply_to_user_id_str = [article valueForKey:@"in_reply_to_user_id_str"];
                 if ([article valueForKey:@"lang"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.lang = @"";
                 }
                 else
                 tweetDetails.lang = [article valueForKey:@"lang"];
                 if ([article valueForKey:@"place"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.place = @"";
                 }
                 else
                 tweetDetails.place = [article valueForKey:@"place"];
                 if ([article valueForKey:@"possibly_sensitive"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.possibly_sensitive = @"";
                 }
                 else
                 tweetDetails.possibly_sensitive = [NSString stringWithFormat:@"%@",[article valueForKey:@"possibly_sensitive"]];
                 if ([article valueForKey:@"retweet_count"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.retweet_count = @"";
                 }
                 else
                 tweetDetails.retweet_count = [NSString stringWithFormat:@"%@",[article valueForKey:@"retweet_count"]];
                 if ([article valueForKey:@"source"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.source = @"";
                 }
                 else
                 tweetDetails.source = [article valueForKey:@"source"];
                 if ([article valueForKey:@"retweeted"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.retweeted = @"";
                 }
                 else
                 tweetDetails.retweeted = [NSString stringWithFormat:@"%@",[article valueForKey:@"retweeted"]];
                 if ([article valueForKey:@"text"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.text = @"";
                 }
                 else
                 tweetDetails.text = [article valueForKey:@"text"];
                 if ([article valueForKey:@"truncated"] == (NSString *)[NSNull null])
                 {
                     tweetDetails.truncated = @"";
                 }
                 else
                 tweetDetails.truncated = [NSString stringWithFormat:@"%@",[article valueForKey:@"truncated"]];
                 [self.tweetDataToDatabase addObject:tweetDetails];
                 
                 //Tweet User Details
                 
                 CDTweetUserDetails *tweetUserDetail = [[CDTweetUserDetails alloc]init];
                 
                 tweetUserDetail.contributors_enabled = (BOOL)[article valueForKeyPath:@"user.contributors_enabled"];
                 tweetUserDetail.created_at = [article valueForKeyPath:@"user.created_at"];
                 tweetUserDetail.default_profile = (BOOL)[article valueForKeyPath:@"user.default_profile"];
                 tweetUserDetail.default_profile_image = (BOOL)[article valueForKeyPath:@"user.default_profile_image"];
                 tweetUserDetail.description_tweet = [article valueForKeyPath:@"user.description_tweet"];
                 tweetUserDetail.favourites_count = [article valueForKeyPath:@"user.favourites_count"];
                 tweetUserDetail.follow_request_sent = (BOOL)[article valueForKeyPath:@"user.follow_request_sent"];
                 tweetUserDetail.followers_count = [article valueForKeyPath:@"user.followers_count"];
                 tweetUserDetail.friends_count = [article valueForKeyPath:@"user.friends_count"];
                 tweetUserDetail.following = (BOOL)[article valueForKeyPath:@"user.following"];
                 tweetUserDetail.geo_enabled = (BOOL)[article valueForKeyPath:@"user.geo_enabled"];
                 tweetUserDetail.userid = [article valueForKeyPath:@"user.userid"];
                 tweetUserDetail.userid_str = [article valueForKeyPath:@"user.userid_str"];
                 tweetUserDetail.is_translation_enabled = (BOOL)[article valueForKeyPath:@"user.is_translation_enabled"];
                 tweetUserDetail.is_translator = (BOOL)[article valueForKeyPath:@"user.is_translator"];
                 tweetUserDetail.lang = [article valueForKeyPath:@"user.lang"];
                 tweetUserDetail.listed_count = [NSString stringWithFormat:@"%@",[article valueForKeyPath:@"user.listed_count"]];
                 tweetUserDetail.location = [article valueForKeyPath:@"user.location"];
                 tweetUserDetail.name = [article valueForKeyPath:@"user.name"];
                 tweetUserDetail.notifications = (BOOL)[article valueForKeyPath:@"user.notifications"];
                 tweetUserDetail.profile_background_color = [article valueForKeyPath:@"user.profile_background_color"];
                 tweetUserDetail.profile_background_image_url = [article valueForKeyPath:@"user.profile_background_image_url"];
                 tweetUserDetail.location = [article valueForKeyPath:@"user.location"];
                 tweetUserDetail.name = [article valueForKeyPath:@"user.name"];
                 tweetUserDetail.notifications = (BOOL)[article valueForKeyPath:@"user.notifications"];
                 tweetUserDetail.profile_background_image_url = [article valueForKeyPath:@"user.profile_background_image_url"];
                 tweetUserDetail.profile_background_image_url_https = [article valueForKeyPath:@"user.profile_background_image_url_https"];
                 tweetUserDetail.profile_background_tile = (BOOL)[article valueForKeyPath:@"user.profile_background_tile"];
                 tweetUserDetail.profile_image_url = [article valueForKeyPath:@"user.profile_image_url"];
                 tweetUserDetail.profile_background_color = [article valueForKeyPath:@"user.profile_background_color"];
                 tweetUserDetail.profile_link_color = [article valueForKeyPath:@"user.profile_link_color"];
                 tweetUserDetail.profile_sidebar_border_color = [article valueForKeyPath:@"user.profile_sidebar_border_color"];
                 tweetUserDetail.profile_sidebar_fill_color = [article valueForKeyPath:@"user.profile_sidebar_fill_color"];
                 tweetUserDetail.profile_text_color = [article valueForKeyPath:@"user.profile_text_color"];
                 tweetUserDetail.profile_text_color = [article valueForKeyPath:@"user.profile_text_color"];
                 tweetUserDetail.profile_use_background_image = (BOOL)[article valueForKeyPath:@"user.profile_use_background_image"];
                 tweetUserDetail.protected_user = [article valueForKeyPath:@"user.protected_user"];
                 tweetUserDetail.screen_name = [article valueForKeyPath:@"user.screen_name"];
                 tweetUserDetail.statuses_count = [NSString stringWithFormat:@"%@",[article valueForKeyPath:@"user.statuses_count"]];
                 tweetUserDetail.time_zone = [article valueForKeyPath:@"user.time_zone"];
                 tweetUserDetail.url = [article valueForKeyPath:@"user.url"];
                 tweetUserDetail.utc_offset = [NSString stringWithFormat:@"%@",[article valueForKeyPath:@"user.utc_offset"]];
                 tweetUserDetail.verified = (BOOL)[article valueForKeyPath:@"user.verified"];
                 
                 [self.tweetUserDataToDatabase addObject:tweetUserDetail];
              
             }
             
             [[CDDatabaseManager databaseManager]savingAllTweetDeatils:self.tweetDataToDatabase AndTweetUserDetails:self.tweetUserDataToDatabase];

         }
         
     }];
    

    
}

@end
