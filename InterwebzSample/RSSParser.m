//
//  RSSParser.m
//  InterwebzSample
//
//  Created by Tomasz Janeczko on 10.01.2013.
//  Copyright (c) 2013 Tomasz Janeczko. All rights reserved.
//

#import "RSSParser.h"

@implementation RSSParser {
    NSMutableArray *_results;
    NSMutableDictionary *_rssItem;
    NSString *_currentItem;
    NSMutableString *_currentValue;
    
    BOOL _inItem;
}

- (id)init
{
    self = [super init];
    if (self) {
        _results = [NSMutableArray new];
        _inItem = NO;
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"item"]) {
        _inItem = YES;
        _rssItem = [NSMutableDictionary new];
    } else if (_inItem) {
        _currentItem = elementName;
        _currentValue = [NSMutableString new];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        _inItem = NO;
        [_results addObject:_rssItem];
        _rssItem = nil;
    } else if (_inItem) {
        _rssItem[_currentItem] = _currentValue;
        _currentValue = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (_inItem) {
        [_currentValue appendString:string];
    }
}

- (NSArray *)results {
    return _results;
}

@end
