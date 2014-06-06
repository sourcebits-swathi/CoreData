//
//  CDSaveTweetAndReTweetInfo.h
//  SampleCoreDataApplication
//
//  Created by Swathi Tata on 06/06/14.
//  Copyright (c) 2014 Swathi Tata. All rights reserved.
//

#import "CDSaveUserInfo.h"

@class CDSaveTweetDetails;

@interface CDSaveTweetAndReTweetInfo : CDSaveUserInfo

@property (nonatomic,assign) BOOL is_translation_enabled;
@property(nonatomic,retain) CDSaveTweetDetails *generaltweetinfo;
@end
