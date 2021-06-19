//
//  SecondViewController.m
//  Interview02-读写安全
//
//  Created by 李雅珠 on 2021/6/19.
//  Copyright © 2021 MJ Lee. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpSubView];
}

- (void)setUpSubView {

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    [self.view layoutIfNeeded];
    // 添加渐隐层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.locations = @[@0, @1];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 0.15);
    gradientLayer.frame = CGRectMake(0, 0, self.bgView.frame.size.width, self.bgView.frame.size.height);
    self.bgView.layer.mask = gradientLayer;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"一蓑烟雨任平生";
    return cell;
}


@end
