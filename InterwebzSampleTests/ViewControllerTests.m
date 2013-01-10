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

@interface ViewController()

- (void)startDownloadingTweets;
- (void)startDownloadingRSSContent;
- (IBAction)rssButtonTapped:(id)sender;
- (IBAction)tweetsButtonTapped:(id)sender;

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
        it(@"should start downloading tweets after dapping Download button", ^{
            id viewController = [ViewController new];

            id mockController = [OCMockObject partialMockForObject:viewController];
            [[mockController expect] startDownloadingTweets];
            
            [viewController tweetsButtonTapped:nil];
            
            [mockController verify];
        });
    });
});

SPEC_END
