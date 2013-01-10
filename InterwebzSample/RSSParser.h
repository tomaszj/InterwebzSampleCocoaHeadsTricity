//
//  RSSParser.h
//  InterwebzSample
//
//  Created by Tomasz Janeczko on 10.01.2013.
//  Copyright (c) 2013 Tomasz Janeczko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSParser : NSObject <NSXMLParserDelegate>

- (NSArray *)results;

@end
