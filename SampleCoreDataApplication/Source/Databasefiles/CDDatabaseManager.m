//
//  CDDatabaseManager.m
//  CoreDataTutorial
//
//  Created by Swathi Tata on 02/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import "CDDatabaseManager.h"
#import "CDTweetDetails.h"
#import "CDSaveTweetDetails.h"
#import "CDTweetUserDetails.h"
#import "CDSaveTweetAndReTweetInfo.h"
#import "CDSaveUserInfo.h"
#import "CDSaveFollowerDetails.h"
@implementation CDDatabaseManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(CDDatabaseManager *)databaseManager
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
            
        }
        return self;
   
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SampleCoreDataApplication" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SampleCoreDataApplication.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark -
#pragma mark - Saving Tweet Details
-(void)savingAllTweetDeatils:(NSMutableArray *)lobjTweetDetails AndTweetUserDetails:(NSMutableArray *)lobjTweetUserDetails
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (int i =0; i<lobjTweetDetails.count;i++) {
        
        CDTweetDetails *tweetDetail = [lobjTweetDetails objectAtIndex:i];
        CDTweetUserDetails *tweetUserDetail = [lobjTweetUserDetails objectAtIndex:i];
    
        CDSaveTweetDetails *saveTweetDetail =[NSEntityDescription insertNewObjectForEntityForName:@"TweetInfo"
                                                                           inManagedObjectContext:context];
        saveTweetDetail.contributors = tweetDetail.contributors;
        saveTweetDetail.coordinates = tweetDetail.coordinates;
        saveTweetDetail.created_at = tweetDetail.created_at;
        saveTweetDetail.favorite_count = tweetDetail.favorite_count;
        saveTweetDetail.favorited = tweetDetail.favorited;
        saveTweetDetail.geo = tweetDetail.geo;
        saveTweetDetail.id_str = tweetDetail.id_str;
        saveTweetDetail.in_reply_to_screen_name = tweetDetail.in_reply_to_screen_name;
        saveTweetDetail.in_reply_to_status_id = tweetDetail.in_reply_to_status_id;
        saveTweetDetail.in_reply_to_status_id_str = tweetDetail.in_reply_to_status_id_str;
        saveTweetDetail.in_reply_to_user_id = tweetDetail.in_reply_to_user_id;
        saveTweetDetail.in_reply_to_user_id_str = tweetDetail.in_reply_to_user_id_str;
        saveTweetDetail.lang = tweetDetail.lang;
        saveTweetDetail.place = tweetDetail.place;
        saveTweetDetail.possibly_sensitive = tweetDetail.possibly_sensitive;
        saveTweetDetail.retweet_count = tweetDetail.retweet_count;
        saveTweetDetail.retweeted = tweetDetail.retweeted;
        saveTweetDetail.source = tweetDetail.source;
        saveTweetDetail.text = tweetDetail.text;
        saveTweetDetail.retweeted = tweetDetail.retweeted;
        saveTweetDetail.truncated = tweetDetail.truncated;
        
//Saving TweetUserDetails
        
        CDSaveTweetAndReTweetInfo *saveTweetAndRetweetInfo =[NSEntityDescription insertNewObjectForEntityForName:@"TweetAndReTweetUserInfo"
                                                                                   inManagedObjectContext:context];
        
        saveTweetAndRetweetInfo.contributors_enabled = tweetUserDetail.contributors_enabled;
        saveTweetAndRetweetInfo.created_at= tweetUserDetail.created_at;
        saveTweetAndRetweetInfo.default_profile= tweetUserDetail.default_profile;
        saveTweetAndRetweetInfo.default_profile_image= tweetUserDetail.default_profile_image;
        saveTweetAndRetweetInfo.description_tweet= tweetUserDetail.description_tweet;
        saveTweetAndRetweetInfo.favourites_count= [NSString stringWithFormat:@"%@",tweetUserDetail.favourites_count];
        saveTweetAndRetweetInfo.follow_request_sent= tweetUserDetail.follow_request_sent;
        saveTweetAndRetweetInfo. followers_count= [NSString stringWithFormat:@"%@",tweetUserDetail.followers_count];
        saveTweetAndRetweetInfo.following= tweetUserDetail.following;
        saveTweetAndRetweetInfo.friends_count= [NSString stringWithFormat:@"%@",tweetUserDetail.friends_count];
        saveTweetAndRetweetInfo.geo_enabled= tweetUserDetail.geo_enabled;
        saveTweetAndRetweetInfo.userid= [NSString stringWithFormat:@"%@",tweetUserDetail.userid];
        saveTweetAndRetweetInfo.userid_str= tweetUserDetail.userid_str;
        saveTweetAndRetweetInfo.is_translation_enabled= tweetUserDetail.is_translation_enabled;
        saveTweetAndRetweetInfo.is_translator= tweetUserDetail.is_translator;
        saveTweetAndRetweetInfo.lang= tweetUserDetail.lang;
        saveTweetAndRetweetInfo.listed_count= tweetUserDetail.listed_count;
        saveTweetAndRetweetInfo.location= tweetUserDetail.location;
        saveTweetAndRetweetInfo.name= tweetUserDetail.name;
        saveTweetAndRetweetInfo.notifications= tweetUserDetail.notifications;
        saveTweetAndRetweetInfo.profile_background_color= tweetUserDetail.profile_background_color;
        saveTweetAndRetweetInfo.profile_background_image_url= tweetUserDetail.profile_background_image_url;
        saveTweetAndRetweetInfo.profile_background_image_url_https= tweetUserDetail.profile_background_image_url_https;
        saveTweetAndRetweetInfo.profile_background_tile= tweetUserDetail.profile_background_tile;
        saveTweetAndRetweetInfo.profile_image_url= tweetUserDetail.profile_image_url;
        saveTweetAndRetweetInfo.profile_image_url_https= tweetUserDetail.profile_image_url_https;
        saveTweetAndRetweetInfo.profile_link_color= tweetUserDetail.profile_link_color;
        saveTweetAndRetweetInfo.profile_sidebar_border_color= tweetUserDetail.profile_sidebar_border_color;
        saveTweetAndRetweetInfo.profile_sidebar_fill_color= tweetUserDetail.profile_sidebar_fill_color;
        saveTweetAndRetweetInfo.profile_text_color= tweetUserDetail.profile_text_color;
        saveTweetAndRetweetInfo.profile_use_background_image= tweetUserDetail.profile_use_background_image;
        saveTweetAndRetweetInfo.protected_user= tweetUserDetail.protected_user;
        saveTweetAndRetweetInfo.screen_name= tweetUserDetail.screen_name;
        saveTweetAndRetweetInfo.statuses_count= tweetUserDetail.statuses_count;
        saveTweetAndRetweetInfo.time_zone= tweetUserDetail.time_zone;
        saveTweetAndRetweetInfo.url= tweetUserDetail.url;
        saveTweetAndRetweetInfo.utc_offset= tweetUserDetail.utc_offset;
        saveTweetAndRetweetInfo. verified= tweetUserDetail.verified;

        saveTweetDetail.tweetuserinfo = saveTweetAndRetweetInfo;
        saveTweetAndRetweetInfo.generaltweetinfo = saveTweetDetail;
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }

    }
    
    //For Checking Purpose whether data is saved or not
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TweetInfo"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSLog(@"fetched objects %@",fetchedObjects);
   
    
}
#pragma mark -
#pragma mark - Saving Follower Details

-(void)savingFollowerDeatails:(NSMutableArray *)lobjfollowerDetails
{
    
    NSManagedObjectContext *context = [self managedObjectContext];

     CDSaveFollowerDetails *saveFollowerDetails = [NSEntityDescription insertNewObjectForEntityForName:@"Followers" inManagedObjectContext:context];
    NSMutableArray *followers = [NSMutableArray array];
    
    
    for (CDTweetUserDetails *tweetUserDetail in lobjfollowerDetails) {
        
          CDSaveUserInfo *saveuserInfodetails =[NSEntityDescription insertNewObjectForEntityForName:@"UserInfo"
                                                                           inManagedObjectContext:context];
        
        saveuserInfodetails.contributors_enabled = tweetUserDetail.contributors_enabled;
        saveuserInfodetails.created_at= tweetUserDetail.created_at;
        saveuserInfodetails.default_profile= tweetUserDetail.default_profile;
        saveuserInfodetails.default_profile_image= tweetUserDetail.default_profile_image;
        saveuserInfodetails.description_tweet= tweetUserDetail.description_tweet;
        saveuserInfodetails.favourites_count= [NSString stringWithFormat:@"%@",tweetUserDetail.favourites_count];
        saveuserInfodetails.follow_request_sent= tweetUserDetail.follow_request_sent;
        saveuserInfodetails. followers_count= [NSString stringWithFormat:@"%@",tweetUserDetail.followers_count];
        saveuserInfodetails.following= tweetUserDetail.following;
        saveuserInfodetails.friends_count= [NSString stringWithFormat:@"%@",tweetUserDetail.friends_count];
        saveuserInfodetails.geo_enabled= tweetUserDetail.geo_enabled;
        saveuserInfodetails.userid= [NSString stringWithFormat:@"%@",tweetUserDetail.userid];
        saveuserInfodetails.userid_str= tweetUserDetail.userid_str;
        saveuserInfodetails.is_translator= tweetUserDetail.is_translator;
        saveuserInfodetails.lang= tweetUserDetail.lang;
        saveuserInfodetails.listed_count= tweetUserDetail.listed_count;
        saveuserInfodetails.location= tweetUserDetail.location;
        saveuserInfodetails.name= tweetUserDetail.name;
        saveuserInfodetails.notifications= tweetUserDetail.notifications;
        saveuserInfodetails.profile_background_color= tweetUserDetail.profile_background_color;
        saveuserInfodetails.profile_background_image_url= tweetUserDetail.profile_background_image_url;
        saveuserInfodetails.profile_background_image_url_https= tweetUserDetail.profile_background_image_url_https;
        saveuserInfodetails.profile_background_tile= tweetUserDetail.profile_background_tile;
        saveuserInfodetails.profile_image_url= tweetUserDetail.profile_image_url;
        saveuserInfodetails.profile_image_url_https= tweetUserDetail.profile_image_url_https;
        saveuserInfodetails.profile_link_color= tweetUserDetail.profile_link_color;
        saveuserInfodetails.profile_sidebar_border_color= tweetUserDetail.profile_sidebar_border_color;
        saveuserInfodetails.profile_sidebar_fill_color= tweetUserDetail.profile_sidebar_fill_color;
        saveuserInfodetails.profile_text_color= tweetUserDetail.profile_text_color;
        saveuserInfodetails.profile_use_background_image= tweetUserDetail.profile_use_background_image;
        saveuserInfodetails.protected_user= tweetUserDetail.protected_user;
        saveuserInfodetails.screen_name= tweetUserDetail.screen_name;
        saveuserInfodetails.statuses_count= tweetUserDetail.statuses_count;
        saveuserInfodetails.time_zone= tweetUserDetail.time_zone;
        saveuserInfodetails.url= tweetUserDetail.url;
        saveuserInfodetails.utc_offset= tweetUserDetail.utc_offset;
        saveuserInfodetails. verified= tweetUserDetail.verified;
        
        [saveFollowerDetails adduserDetailsObject:saveuserInfodetails];

        [followers addObject:saveuserInfodetails];

        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    }
    NSLog(@"followers %@",followers);
    [saveFollowerDetails setUserDetails:[NSSet setWithArray:followers]];
    NSError *error;
    if (![context save:&error]) {
      NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //For Checking Purpose whether data is saved or not
    
    NSError *error1;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Followers"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error1];
    NSLog(@"fetched objects %@",fetchedObjects);
    CDSaveFollowerDetails *follower = [fetchedObjects objectAtIndex:0];
    NSLog(@"details %@",follower.userDetails);
    
    

    
}


@end
