//
//  YCLKeepAdScrollView.m
//  Keep
//
//  Created by 杨承龙 on 16/7/16.
//  Copyright © 2016年 Albert. All rights reserved.
//

#import "YCLKeepAdScrollView.h"
#import "YCLKeepAdLabel.h"

@interface YCLKeepAdScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong)  NSTimer *timer;

@end

@implementation YCLKeepAdScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.scrollsToTop = NO;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollW = self.bounds.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    page--;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidStop:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidStop:scrollView];
}

- (void)scrollViewDidStop:(UIScrollView *)scrollView {
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width;
    int page = (self.contentOffset.x + 0.5 * scrollW) / scrollW;
    if (page == 0) {
        [self setContentOffset:CGPointMake(scrollW * self.titles.count, 0)];
    }else if (page == (self.titles.count + 1)) {
        [self setContentOffset:CGPointMake(scrollW, 0)];
    }
}

#pragma mark - Private Methods

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    self.pageControl.numberOfPages = self.titles.count;
    [self setbanner];
}

- (void)setbanner {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = 30;
    CGFloat Y = self.bounds.size.height - H;
    YCLKeepAdLabel *lastLabel = [[YCLKeepAdLabel alloc] init];
    YCLKeepAdLabel *firstLabel = [[YCLKeepAdLabel alloc] init];
    for ( int i = 0; i < self.titles.count; i++) {
        YCLKeepAdLabel *advertLabel = [[YCLKeepAdLabel alloc] init];
        CGFloat X = i * W + W ;
        advertLabel.frame = CGRectMake(X, Y, W, H);
        advertLabel.text = self.titles[i];
        if (i == 0) {
            firstLabel.text = self.titles[i];
        }
        if (i == self.titles.count - 1) {
            lastLabel.text = self.titles[i];
        }
        [self addSubview:advertLabel];
    }
    lastLabel.frame = CGRectMake(0, Y, W, H);
    [self addSubview:lastLabel];
    
    firstLabel.frame = CGRectMake((self.titles.count + 1) * W, Y, W, H);
    [self addSubview:firstLabel];
    
    CGFloat contentW = (self.titles.count + 2) * W;
    self.contentSize = CGSizeMake(contentW, 0);
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.pageControl.currentPage = 0;
    [self setContentOffset:CGPointMake(W, 0)];
    [self addTimer];
}

- (void)addTimer {
    self.timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage {
    NSInteger page = 0;
    if (self.pageControl.currentPage == self.titles.count) {
        page = 0;
    }else {
        page = self.pageControl.currentPage + 1;
    }
    CGFloat offsetX = (page + 1) * self.bounds.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self setContentOffset:offset animated:YES];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    [self removeTimer];
}

@end
