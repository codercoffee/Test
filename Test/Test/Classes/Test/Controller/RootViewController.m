//
//  RootViewController.m
//  Test
//
//  Created by wk on 16/4/9.
//  Copyright © 2016年 wk. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Test";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *randomString = [KColor kRandomColorToHexString];
    KLog(@"randomString = %@", randomString);
    
    
    
    
    
//    NSString *url = @"http://www.weather.com.cn/data/cityinfo/101010100.html";
//    
//    [KAFN kGet:url parameters:nil success:^(NSDictionary *dict) {
//        
//        KLog(@"%@", dict);
//        
//    } failure:^{
//        
//    }];
    
    
    
    
    
    
    
}


// 隐藏当前页面的导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
