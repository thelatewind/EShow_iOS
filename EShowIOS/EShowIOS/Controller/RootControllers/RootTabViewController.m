//
//  RootTabViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/22.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import "RootTabViewController.h"
#import "BaseNavigationController.h"
#import "MainViewController.h"
#import "FunctionViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"


//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";
#if DEMO_CALL == 1
@interface RootTabViewController () <UIAlertViewDelegate, EMCallManagerDelegate>
#else
@interface RootTabViewController () <UIAlertViewDelegate>
#endif
{
    //    ConversationListController *_chatListVC;
    //    ContactListViewController *_contactsVC;
    
//    CommodityViewController *_chatListVC;
//    OrderViewController *_contactsVC;
    //
    //    UIBarButtonItem *_addFriendItem;
}

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation RootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self setChildControllers];
}
- (void)setChildControllers
{
    MainViewController *communityVC = [[MainViewController alloc] init];
    [self addChildVC:communityVC title:@"首页" image:@"tabbar_05" selectedImage:@"tabbar_01"];
    FunctionViewController *marketVC = [[FunctionViewController alloc] init];
    [self addChildVC:marketVC title:@"功能" image:@"tabbar_06" selectedImage:@"tabbar_02"];
    MessageViewController *internetVC = [[MessageViewController alloc] init];
    [self addChildVC:internetVC title:@"消息" image:@"tabbar_07" selectedImage:@"tabbar_03"];
    MeViewController *profileVC = [[MeViewController alloc] init];
    [self addChildVC:profileVC title:@"我的" image:@"tabbar_08" selectedImage:@"tabbar_04"];
}
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //  传过来一个小控制器 包装一个导航栏
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    //    nav.navigationBar.barStyle = UIBarStyleBlack;
    //    nav.navigationBar.backgroundColor = RGBColor(13, 111, 187);
    nav.navigationBar.tintColor = KTabbarNormalColor;
    // 统一设置导航标题前景色
    NSMutableDictionary *naviBarTextAttrs = [NSMutableDictionary dictionary];
    naviBarTextAttrs[NSForegroundColorAttributeName] = RGBColor(247, 105, 86);
    nav.navigationBar.titleTextAttributes = naviBarTextAttrs;
    // 统一设置导航栏返回按钮 取消返回两个字
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];
    
    nav.tabBarItem.title = title;
    // 包了导航栏之后,tabBarItem设置应在nav控制器上写!
    nav.tabBarItem.image = [UIImage imageNamed:image];
    // 声明:这张图片按照原始的样子显示出来,不要自动渲染成其他颜色(比如蓝色)
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置tabbarItem文字样式 Foreground 前景色
    NSMutableDictionary *tabbarItemTextAttrs = [NSMutableDictionary dictionary];
    tabbarItemTextAttrs[NSForegroundColorAttributeName] = [JKUtil getColor:@"999999"];
    NSMutableDictionary *tabbarItemSelectTextAttrs = [NSMutableDictionary dictionary];
    // 设置tabbarItem文字样式 选中状态的颜色
    tabbarItemSelectTextAttrs[NSForegroundColorAttributeName] = KTabbarNormalColor;
    [nav.tabBarItem setTitleTextAttributes:tabbarItemTextAttrs forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:tabbarItemSelectTextAttrs forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
