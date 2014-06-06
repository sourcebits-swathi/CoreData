//
//  CDDatabaseManager.h
//  CoreDataTutorial
//
//  Created by Swathi Tata on 02/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDDatabaseManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(CDDatabaseManager *)databaseManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)savingAllTweetDeatils:(NSMutableArray *)lobjTweetDetails AndTweetUserDetails:(NSMutableArray *)lobjTweetUserDetails;
-(void)savingFollowerDeatails:(NSMutableArray *)lobjfollowerDetails;
//-(void)savingTweetUserDeatils:(NSMutableArray *)lobjTweetUserDetails;

@end
