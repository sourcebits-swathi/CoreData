//
//  CDTweetDetails.h
//  SampleCoreDataApplication
//
//  Created by Swathi Tata on 03/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CDSaveTweetAndReTweetInfo;


@interface CDSaveTweetDetails : NSManagedObject

@property (nonatomic,retain) NSString *contributors;
@property (nonatomic,retain) NSString *coordinates;
@property (nonatomic,retain) NSString *created_at;
@property (nonatomic,retain) NSString *favorite_count;
@property (nonatomic,retain) NSString *favorited;
@property (nonatomic,retain) NSString *geo;
@property (nonatomic,retain) NSString *idofTweet;
@property (nonatomic,retain) NSString *id_str;
@property (nonatomic,retain) NSString *in_reply_to_screen_name;
@property (nonatomic,retain) NSString *in_reply_to_status_id;
@property (nonatomic,retain) NSString *in_reply_to_status_id_str;
@property (nonatomic,retain) NSString *in_reply_to_user_id;
@property (nonatomic,retain) NSString *in_reply_to_user_id_str;
@property (nonatomic,retain) NSString *lang;
@property (nonatomic,retain) NSString *place;
@property (nonatomic,retain) NSString *possibly_sensitive;
@property (nonatomic,retain) NSString *retweet_count;
@property (nonatomic,retain) NSString *source;
@property (nonatomic,retain) NSString *retweeted;
@property (nonatomic,retain) NSString *text;
@property (nonatomic,retain) NSString *truncated;
@property (nonatomic,retain)CDSaveTweetAndReTweetInfo *tweetuserinfo;
@end
