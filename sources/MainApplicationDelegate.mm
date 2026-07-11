#import <CoreText/CoreText.h>
#import "MainApplicationDelegate.h"
#import "RootViewController.h"
#import <Lottie/Lottie-Swift.h>

@implementation MainApplicationDelegate {
    RootViewController *_rootViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    if (@available(iOS 13.0, *)) {
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    }
    
    _rootViewController = [[RootViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
    navController.navigationBar.prefersLargeTitles = NO;
    navController.navigationBar.translucent = YES;
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];

    // เริ่มต้นเรียกใช้ Lottie Animation View ในฐานะ Splash Screen
    LottieAnimation *animation = [LottieAnimation named:@"splash" bundle:[NSBundle mainBundle] subdirectory:nil animationCache:nil];
    if (animation) {
        LottieAnimationView *animationView = [[LottieAnimationView alloc] initWithAnimation:animation configuration:[LottieConfiguration shared]];
        if (animationView) {
            animationView.frame = self.window.bounds;
            animationView.contentMode = UIViewContentModeScaleAspectFit;
            
            // บังคับให้อยู่บนสุดของ Window ชั่วคราว
            [self.window addSubview:animationView];
            
            // เล่นแอนิเมชันจนจบแล้วค่อยๆ Fade Out ออกเพื่อแสดงหน้า RootViewController
            [animationView playWithCompletion:^(BOOL animationFinished) {
                [UIView animateWithDuration:0.3 animations:^{
                    animationView.alpha = 0.0;
                } completion:^(BOOL finished) {
                    [animationView removeFromSuperview];
                }];
            }];
        }
    }

    return YES;
}

@end
