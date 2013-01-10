//
//  ViewController.m
//  InterwebzSample
//
//  Created by Tomasz Janeczko on 10.01.2013.
//  Copyright (c) 2013 Tomasz Janeczko. All rights reserved.
//

#import "ViewController.h"
#import "RSSParser.h"
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
- (IBAction)tweetsButtonTapped:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://search.twitter.com/search.json?q=ios&rpp=5&result_type=mixed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        _tweets = [JSON[@"results"] copy];
        
        [self.tableView reloadData];
    } failure:nil];
    [operation start];
}
- (IBAction)rssButtonTapped:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://rss.gazeta.pl/pub/rss/duzy_format.xml"]];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        RSSParser *rssParser = [RSSParser new];
        
        XMLParser.delegate = rssParser;
        [XMLParser parse];
        
        _rssEntries = [rssParser results];
        
        NSLog(@"RSS results: %@", _rssEntries);
        
        [self.tableView reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
        NSLog(@"Error: %@", error);
    }];


    [operation start];
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

@end
