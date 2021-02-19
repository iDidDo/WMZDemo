//
//  MainContentVC.m
//  WMZDemo
//
//  Created by Do on 2021/2/17.
//

#import "MainContentVC.h"
#import <WMZPageController/WMZPageController.h>

#define headerViewHeight     700

@interface MainContentVC ()<UICollectionViewDelegate,UICollectionViewDataSource,WMZPageProtocol>


@property (nonatomic, strong) UICollectionView    *collectionView;

@end

@implementation MainContentVC

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (UIScrollView *)getMyScrollView{
    return self.collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.index+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1.0f];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW=[UIScreen mainScreen].bounds.size.width;
    return  CGSizeMake((itemW-30)/2,(itemW-30)/2+55);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10,10, 10);
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width-[[UIApplication sharedApplication] statusBarFrame].size.height-44-83-40) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = UIColor.whiteColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollEnabled = YES;
        [self.view addSubview:self.collectionView];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}


@end
