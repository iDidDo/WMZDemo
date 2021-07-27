//
//  ViewController.m
//  WMZDemo
//
//  Created by Do on 2021/2/17.
//

#import "MainVC.h"
#import "MainContentVC.h"
#import <WMZPageController/WMZPageController.h>

#define kScreenW                        ([UIScreen mainScreen].bounds.size.width)
#define kScreenH                        ([UIScreen mainScreen].bounds.size.height)

#define kNavBarHeight                   ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kNavgitonH                      (kNavBarHeight + 44.0)
#define kTabBarH                        ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)




#define headerViewHeight     700
@interface MainVC ()

@property (nonatomic, strong) UIView    *headerView;
@property (nonatomic, strong) UIView    *navgationView;//假导航View
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=UIColor.whiteColor;
    
    [self config_MainVC];
    
}

#pragma mark --------两个疑问------------
//1、自定义假导航，吸顶后改变标题背景变成黄色，但是一左右滚动背景色又变回初始化设置的颜色。
//2、吸顶后，在collectionView不足一屏情况下（比如标题1-4），触摸 collectionView 区域上下滑动失效。查看“滑动失灵.png”
 

-(void)config_MainVC
{
    WMZPageParam *param =
    PageParam()
    .wTitleArrSet(@[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5"])
    .wViewControllerSet(^UIViewController *(NSInteger index) {
        MainContentVC *vc = [MainContentVC new];
        vc.index = index;
        return vc;
    })
    .wMenuHeightSet(56)
    .wMenuFixWidthSet(1)
    .wMenuBgColorSet(UIColor.whiteColor)
    .wMenuTitleSelectColorSet(UIColor.redColor)
    .wMenuTitleWidthSet(90)
    .wMenuAnimalSet(PageTitleMenuAiQY)
    .wTopSuspensionSet(YES)
    .wBouncesSet(YES)
    .wFromNaviSet(NO)
    .wNaviAlphaSet(YES)
    .wMenuHeadViewSet(^UIView *{
        return self.headerView;
    })
    //导航栏标题透明度变化
    .wEventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
        
        NSLog(@"oldPoint=%lf",oldPoint.y);
        NSLog(@"newPonit=%lf",newPonit.y);
        NSLog(@"headerViewHeight=%d",headerViewHeight);
        
        //导航栏渐变
        if (newPonit.y<=0) {
            self.navgationView.alpha=0;
        }else if (newPonit.y<=headerViewHeight &&newPonit.y>0) {
            self.navgationView.alpha=newPonit.y/headerViewHeight;
             
        }else if(newPonit.y>headerViewHeight){
            self.upSc.backgroundColor=UIColor.yellowColor;
            self.navgationView.alpha=1;
 
        }
        
        
        //标题背景变色-1
        if ((oldPoint.y+kNavgitonH) == headerViewHeight) {
            self.upSc.mainView.backgroundColor=UIColor.yellowColor;
//            for (UIButton *btn in self.upSc.btnArr) {
//                btn.backgroundColor=UIColor.yellowColor;
//            }
        }else{
            self.upSc.mainView.backgroundColor=UIColor.whiteColor;
//            for (UIButton *btn in self.upSc.btnArr) {
//                btn.backgroundColor=UIColor.whiteColor;
//            }
        }
          
    });
    
    
   self.param = param;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:self.navgationView];
        [self.view bringSubviewToFront:self.navgationView];
    });
}

-(UIView *)navgationView
{
    if (!_navgationView) {
        _navgationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kNavgitonH)];
        _navgationView.backgroundColor=UIColor.yellowColor;
        _navgationView.alpha=0.0;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,kNavBarHeight, kScreenW, 44)];
        label.text=@"我是导航";
        [_navgationView addSubview:label];
    }
    return _navgationView;
}

-(UIView *)headerView
{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, headerViewHeight)];
    }
    return _headerView;
}

@end


