//
//  ViewController.m
//  SFJMBProgressHUDDemo
//
//  Created by 沙缚柩 on 2017/3/20.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+Add.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *test;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)testBtnAct:(UIButton *)sender {
    [MBProgressHUD showHUDWithMessage:@"简单文字HUD,1秒自动隐藏"];
}
- (IBAction)loadingHUD:(id)sender {
    MBProgressHUD *waittingHUD = [MBProgressHUD showWaittingHUDWithMeessage:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [waittingHUD dismissAnimated:YES];
    });
}
- (IBAction)loadingTextHUD:(id)sender {
    MBProgressHUD *wattingHUD = [MBProgressHUD showWaittingHUDWithMeessage:@"loading...."];
    [wattingHUD dismissAnimated:YES afterDelay:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
