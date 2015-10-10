//
//  HowToViewController.m
//  My Baby
//
//  Created by Henna on 10/10/15.
//  Copyright (c) 2015 Henna. All rights reserved.
//

#import "HowToViewController.h"
#import "APIManager.h"
#import "Video.h"
#import <XCDYouTubeKit/XCDYouTubeKit.h>

//AIzaSyAWnqNcCoTk_j7oZabHJkVZW0ULVFg5uZ0
@interface HowToViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *videoListTableView;
@property (nonatomic) NSMutableArray *videos;


//@property (strong, nonatomic) MPMoviePlayerController *videoController;


@end

@implementation HowToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.videoListTableView setDataSource:self];
    [self.videoListTableView setDelegate:self];
    [self.searchTextField setDelegate:self];
    
}


- (void) makeFSAPIRequestWithSearchTerm:(NSString*) searchTerm callbackBlock:(void(^)())block{
    NSLog(@"%@", searchTerm);
    //https://www.googleapis.com/youtube/v3/search?part=id,snippet&q=boating&key=AIzaSyAWnqNcCoTk_j7oZabHJkVZW0ULVFg5uZ0
    NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=id,snippet&q=%@&maxResults=50&key=AIzaSyAWnqNcCoTk_j7oZabHJkVZW0ULVFg5uZ0", searchTerm];
    
    NSString *encodedString = [urlString stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL   URLWithString:encodedString];
    [APIManager GETRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.videos = [[NSMutableArray alloc]init];
            
            NSArray *results = [json objectForKey:@"items"];
            
            //NSLog(@"%@", json);
            for (NSDictionary *result in results) {
                
                Video * video = [[Video alloc] init];
                video.title = [[result objectForKey:@"snippet"]objectForKey:@"title"];
                video.videoDescription = [[result objectForKey:@"snippet"]objectForKey:@"description"];
                video.videoID = [[result objectForKey:@"id"] objectForKey:@"videoId"];
                video.videoImageURL = [[[[result objectForKey:@"snippet"]objectForKey:@"thumbnails"] objectForKey:@"medium"] objectForKey:@"url"];
                [self.videos addObject:video];
            }
            block();
        }
        
    }];
    
}

# pragma mark -tableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.videos.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCellIdentifier" forIndexPath:indexPath];
    Video * video = [self.videos objectAtIndex:indexPath.row];
    
    NSURL *imgURL = [NSURL URLWithString:video.videoImageURL];
    NSData *imageData = [NSData dataWithContentsOfURL:imgURL];
    UIImage *imageToDisplay = [UIImage imageWithData:imageData];
    
    cell.textLabel.text = video.title;
    cell.detailTextLabel.text = video.videoDescription;
    cell.imageView.image = imageToDisplay;
    
    return cell;
}

# pragma mark - text field delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    
    NSString * query = @"How To ";
    
    query = [query stringByAppendingString: self.searchTextField.text];
    
    [self makeFSAPIRequestWithSearchTerm:query callbackBlock:^{
        
        [self.videoListTableView reloadData];
    }];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = [self.videos objectAtIndex:indexPath.row];
    
    NSString *videoString = video.videoID;
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:videoString];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];

}




@end
