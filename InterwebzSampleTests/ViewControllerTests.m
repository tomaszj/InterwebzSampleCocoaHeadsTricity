//
//  ViewControllerTests.m
//  InterwebzSample
//
//  Created by Tomasz Janeczko on 10.01.2013.
//  Copyright (c) 2013 Tomasz Janeczko. All rights reserved.
//

#import "ViewControllerTests.h"
#import <OCMock/OCMock.h>
#import <Kiwi/Kiwi.h>

#import "ViewController.h"
#import "InterwebzService.h"

@interface ViewController()

- (void)startDownloadingTweets;
- (void)startDownloadingRSSContent;
- (IBAction)rssButtonTapped:(id)sender;
- (IBAction)tweetsButtonTapped:(id)sender;
- (InterwebzService *)service;

@end

@implementation ViewControllerTests

- (void)testIfStartsTweetsDownloadingonTweetsButtonTap {
    ViewController *viewController = [ViewController new];
    
    id mockController = [OCMockObject partialMockForObject:viewController];
    [[mockController expect] startDownloadingTweets];
    
    [viewController tweetsButtonTapped:nil];
    
    [mockController verify];
}

@end

SPEC_BEGIN(ViewControllerSpec)

describe(@"ViewController", ^{
    context(@"When presented to the user", ^{
        __block id viewController;
        __block id mockController;
        
        beforeEach(^{
            viewController = [ViewController new];
            mockController = [OCMockObject partialMockForObject:viewController];
        });
        
        it(@"should start downloading tweets after tapping Download button", ^{
            [[mockController expect] startDownloadingTweets];
            
            [viewController tweetsButtonTapped:nil];
            
            [mockController verify];
        });
        
        it(@"should start downloading rss content after tapping Download RSS button", ^{
            [[mockController expect] startDownloadingRSSContent];
            
            [viewController rssButtonTapped:nil];
            
            [mockController verify];
        });
        
        id serviceMock = [OCMockObject mockForClass:[InterwebzService class]];
        
        it(@"should call rss service method", ^{
            [[serviceMock expect] downloadRSSWithSuccessBlock:[OCMArg any]];
            [[[mockController stub] andReturn:serviceMock] service];
            
            [viewController startDownloadingRSSContent];
            
            [serviceMock verify];
        });
        
        it(@"should call tweets service method", ^{
            [[serviceMock expect] downloadTweetsJSONWithSuccessBlock:[OCMArg any]];
            [[[mockController stub] andReturn:serviceMock] service];
            
            [viewController startDownloadingTweets];
            
            [serviceMock verify];
        });
    });
});

SPEC_END
