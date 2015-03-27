//
//  Event.h
//  Git-TaskRabbit
//
//  Created by Kevin Nguy on 3/27/15.
//  Copyright (c) 2015 TaskRabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EventType) {
    EventForkType,
    EventWatchType,
};

@interface Event : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) EventType type;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *repoName;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *avatarImageURLString;

+ (Event *)eventWithJSON:(NSDictionary *)jsonDictionary;

@end
