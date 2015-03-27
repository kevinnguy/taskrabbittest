#import <UIKit/UIKit.h>

#import "Event.h"

@interface RepoDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *repoNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *codingLanguageLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdAtLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfActionsLabel;

@property (nonatomic, strong) Event *event;

@end

