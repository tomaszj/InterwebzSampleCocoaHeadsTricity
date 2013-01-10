//
//  InterwebzService.h
//  InterwebzSample
//
//  Created by Tomasz Janeczko on 10.01.2013.
//  Copyright (c) 2013 Tomasz Janeczko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterwebzService : NSObject

- (void)downloadTweetsJSONWithSuccessBlock:(void(^)(id JSON))successBlock;
- (void)downloadRSSWithSuccessBlock:(void(^)(id rssEntries))successBlock;

@end
