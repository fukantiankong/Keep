//
//  ViewController.m
//  Keep
//
//  Created by 杨承龙 on 16/7/16.
//  Copyright © 2016年 Albert. All rights reserved.
//

#import "ViewController.h"
#import "YCLKeepNewFeatureView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (nonatomic, strong)  MPMoviePlayerController *moviePlayerController;
@property (nonatomic, strong)  YCLKeepNewFeatureView *keepView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *moviePath = [[NSBundle mainBundle]pathForResource:@"keep" ofType:@"mp4"];
    self.moviePlayerController.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    [self.moviePlayerController play];
    [self.moviePlayerController.view bringSubviewToFront:self.keepView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSNotificationCenter 
- (void)playbackStateChanged {
    MPMoviePlaybackState playbackState = [self.moviePlayerController playbackState];
    if (playbackState == MPMoviePlaybackStateStopped || playbackState == MPMoviePlaybackStatePaused) {
        [self.moviePlayerController play];
    }
}

#pragma mark - LazyLoad 懒加载
- (MPMoviePlayerController *)moviePlayerController {
    if(_moviePlayerController == nil) {
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
        [_moviePlayerController setShouldAutoplay:YES];
        [_moviePlayerController setFullscreen:YES];
        _moviePlayerController.movieSourceType = MPMovieSourceTypeFile;
        [_moviePlayerController setRepeatMode:MPMovieRepeatModeOne];
        _moviePlayerController.controlStyle = MPMovieControlStyleNone;
        _moviePlayerController.view.frame = [UIScreen mainScreen].bounds;
        [self.view addSubview:self.moviePlayerController.view];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    }
    return _moviePlayerController;
}

- (YCLKeepNewFeatureView *)keepView {
    if(_keepView == nil) {
        _keepView = [[YCLKeepNewFeatureView alloc] init];
        _keepView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self.moviePlayerController.view addSubview:_keepView];
    }
    return _keepView;
}

@end
