//
//  LXPageControl.m
//  FreelyHeath
//
//  Created by LX Zeng on 2018/10/13.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "LXPageControl.h"

#define itemsCount self.numberOfPages

#define itemWidth self.itemWidth
#define itemHeight self.itemHeight
#define itemSpacing self.itemSpacing

#define selectedImage ((self.selectedImage) ? self.selectedImage : [UIImage getImageWithColor:self.selectedColor])
#define unselectedImage ((self.unselectedImage) ? self.unselectedImage : [UIImage getImageWithColor:self.unselectedColor])

@implementation LXPageControl

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    
    if (self.subviews.count) {
        for (int i = 0; i < self.subviews.count; i++) {
            UIButton *btn = self.subviews[i];
            btn.selected = (currentPage == i) ? YES : NO;
        }
    }
}

- (void)setupPageControl {
    for (int i = 0; i < itemsCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(itemWidth+itemSpacing), 0, itemWidth, itemHeight);
        btn.backgroundColor = SYS_Yellow_Color;
        btn.layer.cornerRadius = 1;
        btn.layer.masksToBounds = YES;
        [btn setBackgroundImage:unselectedImage forState:UIControlStateNormal];
        [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
        btn.selected = (i == self.currentPage) ? YES : NO;
        [self addSubview:btn];
    }
}

@end
