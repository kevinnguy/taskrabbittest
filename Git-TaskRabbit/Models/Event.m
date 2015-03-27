//
//  Event.m
//  Git-TaskRabbit
//
//  Created by Kevin Nguy on 3/27/15.
//  Copyright (c) 2015 TaskRabbit. All rights reserved.
//

#import "Event.h"

@implementation Event

+ (Event *)eventWithJSON:(NSDictionary *)jsonDictionary
{
    if (!jsonDictionary) {
        return nil;
    }
    
    Event *event = [Event new];
    event.id = jsonDictionary[@"id"];
    
    if ([jsonDictionary[@"type"] isEqualToString:@"ForkEvent"]) {
        event.type = EventForkType;
    }
    else if ([jsonDictionary[@"type"] isEqualToString:@"WatchEvent"]) {
        event.type = EventWatchType;
    }
    
    event.username = jsonDictionary[@"actor"][@"login"];
    event.repoName = jsonDictionary[@"repo"][@"name"];
    event.repoName = [event.repoName stringByReplacingOccurrencesOfString:@"taskrabbit/" withString:@""];
    event.avatarImageURLString = jsonDictionary[@"actor"][@"avatar_url"];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"]; // 2015-03-25T14:12:11Z
    event.createdAt = [dateFormatter dateFromString:jsonDictionary[@"created_at"]];
    
    return event;
}

@end
