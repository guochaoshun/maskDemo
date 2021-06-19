//
//  ViewController.m
//  Interview02-读写安全
//
//  Created by MJ Lee on 2018/6/19.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hiddenImageView;

@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpSubView];

}

- (void)setUpSubView {

    self.hiddenImageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.hiddenImageView addGestureRecognizer:pan];


    CGFloat width = 300;
    // 方式1: 通过layer.mask
    self.maskLayer = [CALayer layer];
    self.maskLayer.frame = CGRectMake(20, 200, width, width);
    self.maskLayer.cornerRadius = width*0.5;
    self.maskLayer.backgroundColor = UIColor.whiteColor.CGColor;
    self.hiddenImageView.layer.mask = self.maskLayer;

    // 方式2: 通过view.maskView实现效果一致
//    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(20, 200, width, width)];
//    self.maskView.backgroundColor = UIColor.whiteColor;
//    self.maskView.layer.cornerRadius = width*0.5;
//    self.hiddenImageView.maskView = self.maskView ;
}

- (void)panAction:(UIPanGestureRecognizer *)pan {

    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {// 开始拖拽

        }
            break;
        case UIGestureRecognizerStateChanged: {// 拖拽中
            CGPoint translation = [pan translationInView:self.hiddenImageView];
            if (self.maskLayer) {
                // CATransaction有隐式动画,使用setDisableActions禁掉隐式动画
                // 如果没有setDisableActions,这样会导致拖动的时候不跟手
                [CATransaction begin];
                [CATransaction setDisableActions:YES];
                self.maskLayer.position = CGPointMake(self.maskLayer.position.x+translation.x, self.maskLayer.position.y+translation.y);
                [CATransaction commit];
            } else if (self.maskView) {
                self.maskView.center = CGPointMake(self.maskView.center.x+translation.x, self.maskView.center.y+translation.y);
            }
            [pan setTranslation:CGPointZero inView:self.hiddenImageView];

        }
            break;
        case UIGestureRecognizerStateEnded: {// 拖拽结束

        }
            break;
        default: {// 其他异常情况当拖拽结束处理

        }
            break;
    }

}


@end
