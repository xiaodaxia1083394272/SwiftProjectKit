//
//  SPTestBriage.m
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/28.
//  Copyright © 2018年 HMRL. All rights reserved.
//

#import "SPTestBriage.h"
#import <SwiftProjectKit-Swift.h>

@interface SPTestBriage ()

@end

@implementation SPTestBriage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
//    self.navigationItem.title = @"这是oc的controller";
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, 50, 200, 30)];
    titleLB.text = @"这是oc的controller";
    [self.view addSubview:titleLB];
    
    UIButton *btn = [[UIButton alloc] initWithFrame: CGRectMake(0, 30, 60, 50)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(clickDismissBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //call
    UIButton *OcCallSwift = [[UIButton alloc] initWithFrame: CGRectMake(0, 70, 60, 50)];
    [OcCallSwift setTitle:@"swift调oc" forState:UIControlStateNormal];
    OcCallSwift.backgroundColor = [UIColor greenColor];
    [OcCallSwift addTarget:self action:@selector(clickOcCallSwift) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OcCallSwift];
    
}

- (void)clickOcCallSwift{
   
    SPSwiftTestBriageObj *obj = [SPSwiftTestBriageObj new];
    
}


- (void)clickDismissBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)swiftCallOC{
    
    NSLog(@"swift调用oc");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"swift调用oc" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


@end
