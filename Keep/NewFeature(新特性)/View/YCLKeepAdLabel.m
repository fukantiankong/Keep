//
//  YCLKeepAdLabel.m
//  Keep
//
//  Created by 杨承龙 on 16/7/16.
//  Copyright © 2016年 Albert. All rights reserved.
//

#import "YCLKeepAdLabel.h"

@implementation YCLKeepAdLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont fontWithName:@"Helvetica" size:23.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

@end
