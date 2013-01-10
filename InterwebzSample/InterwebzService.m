//
//  InterwebzService.m
//  InterwebzSample
//
//  Created by Tomasz Janeczko on 10.01.2013.
//  Copyright (c) 2013 Tomasz Janeczko. All rights reserved.
//

#import "InterwebzService.h"
#import "RSSParser.h"
#import <AFNetworking.h>

@implementation InterwebzService

- (void)downloadTweetsJSONWithSuccessBlock:(void(^)(id JSON))successBlock {
    NSURL *url = [NSURL URLWithString:@"http://search.twitter.com/search.json?q=ios&rpp=5&result_type=mixed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (successBlock) {
            successBlock(JSON);
        }
    } failure:nil];
    [operation start];
}

- (void)downloadRSSXMLWithSuccessBlock:(void(^)(NSXMLParser *parser))successBlock {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rss.gazeta.pl/pub/rss/duzy_format.xml"]];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        if (successBlock) {
            successBlock(XMLParser);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
}

- (void)downloadRSSWithSuccessBlock:(void(^)(id rssEntries))successBlock {
    
    [self downloadRSSXMLWithSuccessBlock:^(NSXMLParser *parser) {
        RSSParser *rssParser = [RSSParser new];
        
        parser.delegate = rssParser;
        [parser parse];
        
        NSArray *results = [rssParser results];
        if (successBlock) {
            successBlock(results);
        }
    }];
}

@end
