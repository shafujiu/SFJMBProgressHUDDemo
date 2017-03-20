//
//  MBProgressHUD+Add.h
//  CocoaPodProject
//
//  Created by ZhaoWei on 16/9/23.
//  Copyright © 2016年 ZhaoWei. All rights reserved.
//  注意 如果两个HUD 叠在一起，那么只能看见第二个因为同时加到keyWindow上 后者覆盖前者

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Add)
// 默认时间1秒 简单的文本提醒
+ (instancetype)showHUDWithMessage:(NSString *)message;
+ (instancetype)showHUDWithMessage:(NSString *)message afterDelay:(NSTimeInterval)delay;

// 读条 + 文本提醒 默认不提供消失
+ (instancetype)showWaittingHUDWithMeessage:(NSString *)message;

// 隐藏
- (void)dismissAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
