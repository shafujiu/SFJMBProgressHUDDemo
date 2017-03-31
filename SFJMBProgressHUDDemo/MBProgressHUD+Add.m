//
//  MBProgressHUD+Add.m
//  CocoaPodProject
//
//  Created by ZhaoWei on 16/9/23.
//  Copyright © 2016年 ZhaoWei. All rights reserved.
//

#import "MBProgressHUD+Add.h"

static CGFloat const SFJDefaultDelay = 1.0; // 默认显示时间
static CGFloat const SFJDefaultMargin = 10; // 提示框边距


@implementation MBProgressHUD (Add)

#pragma mark - 显示单独的消息
+ (instancetype)showHUDWithMessage:(NSString *)message{
    
    return [self showHUDWithMessage:message afterDelay:SFJDefaultDelay];
};

+ (instancetype)showHUDWithMessage:(NSString *)message afterDelay:(NSTimeInterval)delay{
    
    MBProgressHUD *hud = [MBProgressHUD p_HUDWithMessage:message];
    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

+ (instancetype)p_HUDWithMessage:(NSString *)message{
    
    MBProgressHUD *hud = [self p_creatHUD];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    return hud;
}

#pragma mark - 显示消息 + 进度读条
+ (instancetype)showWaittingHUDWithMeessage:(NSString *)message{
    return [self p_showProgressWithMessage:message progressHUDMode:MBProgressHUDModeIndeterminate];
}

+ (instancetype)showProgressWithMessage:(NSString *)message{
    return [self p_showProgressWithMessage:message progressHUDMode:MBProgressHUDModeAnnularDeterminate];
}

+ (instancetype)p_showProgressWithMessage:(NSString *)message progressHUDMode:(MBProgressHUDMode)mode{
    MBProgressHUD *hud = [self p_creatHUD];
    hud.label.text = message;
    hud.mode = mode;
    return hud;
}


+ (instancetype)p_creatHUD{
    dispatch_queue_t globalqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block MBProgressHUD *hud;
    dispatch_sync(globalqueue, ^{
        UIWindow *keyWind = [[UIApplication sharedApplication] keyWindow];
        hud = [MBProgressHUD showHUDAddedTo:keyWind animated:NO];
        // 提醒的内容的背景
        hud.bezelView.backgroundColor = [UIColor blackColor];
        // 文字 + 进度条颜色
        hud.contentColor = [UIColor whiteColor];
        hud.margin = SFJDefaultMargin;
    });
    return hud;
}

- (void)dismissAnimated:(BOOL)animated{
    
    [self hideAnimated:animated];
}

- (void)dismissAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay{
    [self hideAnimated:animated afterDelay:delay];
}

@end
