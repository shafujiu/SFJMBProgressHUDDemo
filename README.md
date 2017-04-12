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

```Objective-c
// 优化 分析发现，线程是多余的。
+ (instancetype)p_creatHUD;
```
> 无论我们创建控件是放在哪个线程是没关系的，但是必须保证的是UI控件的使用最终是在UI线程（也就是主线程）

```Objective-c
+ (instancetype)p_creatHUD{
    dispatch_queue_t globalqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block MBProgressHUD *hud;
    dispatch_sync(globalqueue, ^{
        UIWindow *keyWind = [[UIApplication sharedApplication] keyWindow];
        NSAssert(keyWind, @"keyWindow must not be nil");
        hud = [MBProgressHUD showHUDAddedTo:keyWind animated:NO];
        // 提醒的内容的背景
        hud.bezelView.backgroundColor = [UIColor blackColor];
        // 文字 + 进度条颜色
        hud.contentColor = [UIColor whiteColor];
        hud.margin = SFJDefaultMargin;
    });
    return hud;
}
```

> 在上面的函数，添加的线程是无意义的，因为dispatch_sync 串行，完全没有改变执行的顺序。只是将创建的过程放到了globalqueue队列里面。
使用的时候，无论是在什么线程都没关系，只要最后的使用保证是在主线程就行
例如：
```Objective-c
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDWithMessage:@"简单文字HUD,1秒自动隐藏"];
        });
    });
```

