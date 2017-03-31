# SFJMBProgressHUDDemo
该demo的主要目的是介绍二次封装MBProgressHUD 的分类 MBPregressHUD+Add.h 的使用

MBPregressHUD+Add 该分类主要提供6个方法
```Objective-c
// 默认时间1秒 简单的文本提醒
+ (instancetype)showHUDWithMessage:(NSString *)message;
+ (instancetype)showHUDWithMessage:(NSString *)message afterDelay:(NSTimeInterval)delay;

// 读条 + 文本提醒 默认不提供消失
+ (instancetype)showWaittingHUDWithMeessage:(NSString *)message;
// 进度条
+ (instancetype)showProgressWithMessage:(NSString *)message;
// 隐藏
- (void)dismissAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;
```

```Objective-c
// 在.m 文件中增加私有方法 通过该方法改变mode 实现进度条样式的hud(progressHUD)，以及菊花hud （waittingHUD）
+ (instancetype)p_showProgressWithMessage:(NSString *)message progressHUDMode:(MBProgressHUDMode)mode;
```
通常 第一个跟第四个方法就够用了具体使用请参考Demo
注意，hud都是默认添加到主窗口的，所以如果同时出现两个HUD，会出现后者遮挡前者的情况。
希望能分享一下各位的意见，看如何应对这样的情况更合理。
