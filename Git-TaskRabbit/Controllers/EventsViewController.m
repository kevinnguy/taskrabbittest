#import "EventsViewController.h"
#import "EventCollectionViewCell.h"
#import "RepoDetailViewController.h"

#import "Event.h"

#import <AFNetworking.h>

@interface EventsViewController ()
@property (nonatomic, strong) NSMutableArray *eventDataSource;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [NSDateFormatter new];
    [self.dateFormatter setDateFormat:@"MMM d, yyyy"]; //Jan 1, 2015

    [self setupTableView];
    [self setupDataSource];
}

- (void)setupDataSource
{
    self.eventDataSource = [NSMutableArray new];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.github.com/orgs/taskrabbit/events" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
       
        NSArray *jsonArray = responseObject;
        for (NSDictionary *eventJSONDictionary in jsonArray) {
            [self.eventDataSource addObject:[Event eventWithJSON:eventJSONDictionary]];
        }
        
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)setupTableView
{
    UINib *nib = [UINib nibWithNibName:@"EventCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"EventCollectionViewCell"];
}

- (NSString *)title {
    return @"Stream";
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.eventDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventCollectionViewCell *cell = (EventCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"EventCollectionViewCell" forIndexPath:indexPath];
    Event *event = self.eventDataSource[indexPath.row];
    
    cell.actionTakenLabel.text = @"Unknown"; // Default
    if (event.type == EventForkType) {
        cell.actionTakenLabel.text = @"Fork";
    }
    else if (event.type == EventWatchType) {
        cell.actionTakenLabel.text = @"Watch";
    }
    
    cell.repoNameLabel.text = event.repoName;
    cell.dateLabel.text = [self.dateFormatter stringFromDate:event.createdAt];
    cell.userNameLabel.text = event.username;
    cell.userAvatarImageView.image = nil;
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[RepoDetailViewController new] animated:YES];
}

@end
