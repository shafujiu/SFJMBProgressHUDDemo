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
{
    MBProgressHUD *progressHUD_;
    CADisplayLink *displaylink_;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)testBtnAct:(UIButton *)sender {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDWithMessage:@"简单文字HUD,1秒自动隐藏"];
        });
    });
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

static CGFloat times = 0;

- (IBAction)progress:(id)sender {
    times = 0;
    progressHUD_ = [MBProgressHUD showProgressWithMessage:@"正在加载..."];
    
    displaylink_ = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgressValue:)];
    [displaylink_ addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

// 在下载的时候使用 通常 在downLoadProgress的block里面去设置progress
- (void)updateProgressValue:(CADisplayLink *)sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        times += displaylink_.duration;
        progressHUD_.progress = (times) / 5.0;
        
        if (times >= 5) {
            [progressHUD_ dismissAnimated:YES];
            [displaylink_ invalidate];
        }
    });
}

/**
 NSString *url = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.1.1.dmg";
 MBProgressHUD *hud = [MBProgressHUD showProgressWithMessage:@"loading..."];
 [SFJNetworkingTool downloadFileWithUrl:url Parameter:nil SavedPath:nil Complete:^(NSData *data, NSError *error) {
 [hud dismissAnimated:YES];
 } Progress:^(id downloadProgress, double currentValue) {
 dispatch_async(dispatch_get_main_queue(), ^{
 hud.progress = currentValue;
 });
 NSLog(@"%@",[NSThread currentThread]);
 }];
 */


@end
