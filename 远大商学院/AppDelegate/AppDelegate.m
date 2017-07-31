//
//  AppDelegate.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/3/30.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
// 

#import "AppDelegate.h"
#import "ViewController.h"
#import "LoginAutoViewController.h"
#import "LoginController.h"

@interface AppDelegate ()

@property (nonatomic,strong) Reachability *hostReach;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 友盟分享
    [UMSocialData setAppKey:@"57ac3bd3e0f55a4c04002230"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx5b9ea0210c083f7b" appSecret:@"8c97995cd734a66d0583f3dec359066e" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，分享URL
    [UMSocialQQHandler setQQWithAppId:@"1105529153" appKey:@"TARTixGLbHKxRSIQ" url:@"http://www.umeng.com/social"];
    
    // 判断网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    [self.hostReach startNotifier];  //开始监听,会启动一个run loop
    self.isReachable = YES;
    
    // @"everLaunched" 用来判断用户以前是否登录过
    // @"firstLaunch" 用来判断 在程序的其他部分的判断
    // 第一次程序启动的时候，key @"everLaunched" 不会被赋值的，设置为YES
    //                       @"firstLaunch" 设置为YES。
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];
        ViewController *firstView = [[ViewController alloc]init];
        self.window.rootViewController = firstView;
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        
        NetworkStatus status=[self.hostReach currentReachabilityStatus];
        if (status==0) {
            LoginController *login=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginController"];
            self.window.rootViewController=login;
   
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
#pragma clang diagnostic pop
            [alert show];
        }else{
            LoginAutoViewController *loginAutoVC=[[LoginAutoViewController alloc] init];
            self.window.rootViewController=loginAutoVC;
        }
    }
    
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

// 网络链接改变时会调用的方法
-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
//    NSLog(@"%ld",(long)status);
    if(status == NotReachable)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
#pragma clang diagnostic pop
        [alert show];
        self.isReachable = NO;
    }
    else
    {
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接信息" message:@"网络连接正常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
         */
        self.isReachable = YES; 
    }  
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
