//
//  ViewController.m
//  InterwebzSample
//
//  Created by Tomasz Janeczko on 10.01.2013.
//  Copyright (c) 2013 Tomasz Janeczko. All rights reserved.
//

#import "ViewController.h"
#import "RSSParser.h"
#import "InterwebzService.h"
#import <AFNetworking/AFXMLRequestOperation.h>

@implementation ViewController {
    NSArray *_tweets;
    NSArray *_rssEntries;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [AFXMLRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"application/rss+xml"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)startDownloadingTweets {
    InterwebzService *service = [self service];

    [service downloadTweetsJSONWithSuccessBlock:^(id JSON) {
        _tweets = [JSON[@"results"] copy];
        
        [self.tableView reloadData];
    }];
}

- (IBAction)tweetsButtonTapped:(id)sender {
    [self startDownloadingTweets];
}

- (void)startDownloadingRSSContent {
    InterwebzService *service = [self service];
    
    [service downloadRSSWithSuccessBlock:^(id rssEntries) {
        _rssEntries = rssEntries;
        
        [self.tableView reloadData];

    }];
}

- (IBAction)rssButtonTapped:(id)sender {
    [self startDownloadingRSSContent];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *cellTitle;
    
    switch (section) {
        case 0:
            cellTitle = @"Tweets for #iOS";
            break;
        case 1:
            cellTitle = @"RSS";
            break;
        default:
            cellTitle = @"Wrong!";
            break;
    }
    
    return cellTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rowCount;
    
    switch (section) {
        case 0:
            rowCount = [_tweets count];
            break;
        case 1:
            rowCount = [_rssEntries count];
            break;
        default:
            rowCount = 0;
            break;
    }
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            // Tweet
            NSDictionary *tweetDict = _tweets[indexPath.row];
            cell.textLabel.text = tweetDict[@"text"];
            cell.detailTextLabel.text = tweetDict[@"from_user_name"];
        }
            break;
            
        case 1:
            // RSS
        {
            NSDictionary *rssDict = _rssEntries[indexPath.row];
            cell.textLabel.text = rssDict[@"title"];
            cell.detailTextLabel.text = rssDict[@"pubDate"];
        }
        default:
            break;
    }
    
    
    
    
    return cell;
}

#pragma mark - Private methods
- (InterwebzService *)service {
    return [InterwebzService new];
}

@end
