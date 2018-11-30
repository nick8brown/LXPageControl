//
//  ViewController.m
//  LXPageControl
//
//  Created by LX Zeng on 2018/11/30.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "ViewController.h"

#import "LXPageControl.h"

#import "Masonry.h"

#define PAGE 5

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (nonatomic, strong) LXPageControl *pageControl;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义pageControl";
    
    // 初始化导航栏
    [self setupNavBar];

    // 初始化view
    [self setupView];
}

#pragma mark - 初始化导航栏
- (void)setupNavBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:AppFont(18), NSForegroundColorAttributeName:SYS_White_Color}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithColor:AppHTMLColor(@"4bccbc")] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 初始化view
- (void)setupView {
    CGFloat imgViewY = 0;
    CGFloat imgViewW = kScreen_WIDTH;
    CGFloat imgViewH = 160;
    for (int i = 0; i < PAGE; i++) {
        CGFloat imgViewX = i * imgViewW;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        imgView.backgroundColor = [UIColor randomColor];
        [self.scrollView addSubview:imgView];
    }
    self.scrollView.contentSize = CGSizeMake(PAGE*kScreen_WIDTH, 0);
    
    // 初始化pageControlView
    [self setupPageControlView:PAGE];
}

#pragma mark - 自定义pageControl
- (void)setupPageControlView:(NSInteger)page {
    LXPageControl *pageControl = [[LXPageControl alloc] init];
    pageControl.numberOfPages = page;
    pageControl.itemWidth = 9;
    pageControl.itemHeight = 2;
    pageControl.itemSpacing = 5;
//    pageControl.selectedImage = ImageNamed(@"");
//    pageControl.unselectedImage = ImageNamed(@"");
    pageControl.selectedColor = AppHTMLColor(@"f1f7ca");
    pageControl.unselectedColor = AppHTMLColor(@"99dad3");
    [self.pageView addSubview:pageControl];
    
    CGSize itemSize = CGSizeMake(page*(pageControl.itemWidth+pageControl.itemSpacing), pageControl.itemHeight);
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pageView.mas_bottom).with.offset(-20);
        make.centerX.equalTo(self.pageView);
        make.size.mas_equalTo(itemSize);
    }];
    
    [pageControl setupPageControl];
    
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSInteger index = scrollView.contentOffset.x / kScreen_WIDTH;
        self.pageControl.currentPage = index;
    }
}

@end
