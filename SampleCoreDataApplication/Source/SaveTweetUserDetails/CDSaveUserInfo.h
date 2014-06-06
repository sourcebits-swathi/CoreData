//
//  CDSaveTweetUserDetails.h
//  SampleCoreDataApplication
//
//  Created by Swathi Tata on 04/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CDSaveUserInfo.h"

@class CDSaveFollowerDetails;


@interface CDSaveUserInfo : NSManagedObject

@property (nonatomic,assign) BOOL contributors_enabled;
@property (nonatomic,retain) NSString *created_at;
@property (nonatomic,assign) BOOL  default_profile;
@property (nonatomic,assign) BOOL default_profile_image;
@property (nonatomic,retain) NSString *description_tweet;
@property (nonatomic,retain) NSString *favourites_count;
@property (nonatomic,assign) BOOL follow_request_sent;
@property (nonatomic,retain) NSString *followers_count;
@property (nonatomic,assign)BOOL following;
@property (nonatomic,retain) NSString *friends_count;
@property (nonatomic,assign) BOOL geo_enabled;
@property (nonatomic,retain) NSString *userid;
@property (nonatomic,retain) NSString *userid_str;
@property (nonatomic,assign) BOOL  is_translator;
@property (nonatomic,retain) NSString *lang;
@property (nonatomic,retain) NSString *listed_count;
@property (nonatomic,retain) NSString *location;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,assign) BOOL notifications;
@property (nonatomic,retain) NSString *profile_background_color;
@property (nonatomic,retain) NSString *profile_background_image_url;
@property (nonatomic,retain) NSString *profile_background_image_url_https;
@property (nonatomic,assign) BOOL  profile_background_tile;
@property (nonatomic,retain) NSString *profile_image_url;
@property (nonatomic,retain) NSString *profile_image_url_https;
@property (nonatomic,retain) NSString *profile_link_color;
@property (nonatomic,retain) NSString *profile_sidebar_border_color;
@property (nonatomic,retain) NSString *profile_sidebar_fill_color;
@property (nonatomic,retain) NSString *profile_text_color;
@property (nonatomic,assign) BOOL profile_use_background_image;
@property (nonatomic,retain) NSString *protected_user;
@property (nonatomic,retain) NSString *screen_name;
@property (nonatomic,retain) NSString *statuses_count;
@property (nonatomic,retain) NSString *time_zone;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,retain) NSString *utc_offset;
@property (nonatomic,assign) BOOL verified;
@property (nonatomic,retain) CDSaveFollowerDetails *followers;

@end
