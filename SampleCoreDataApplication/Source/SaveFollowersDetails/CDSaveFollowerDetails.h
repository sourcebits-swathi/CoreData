//
//  CDSaveFollowerDetails.h
//  SampleCoreDataApplication
//
//  Created by Swathi Tata on 06/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import <CoreData/CoreData.h>
@class CDSaveUserInfo;

@interface CDSaveFollowerDetails : NSManagedObject

@property (nonatomic,retain) NSSet *userDetails;

@end

@interface CDSaveFollowerDetails (CoreDataGeneratedAccessors)

- (void)adduserDetailsObject:(CDSaveUserInfo *)value;
- (void)removeuserDetailsObject:(CDSaveUserInfo *)value;
- (void)addadduserDetails:(NSSet *)values;
- (void)removeadduserDetails:(NSSet *)values;

@end