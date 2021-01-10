//
//  ZJJLocationNotiManager.m
//  ZJJLocationNotification
//
//  Created by admin on 2020/12/29.
//

#import "ZJJLocationNotiManager.h"
#import <UserNotifications/UserNotifications.h>

@interface ZJJLocationNotiManager () <UNUserNotificationCenterDelegate>

@end

@implementation ZJJLocationNotiManager

/// 创建单例
+ (instancetype)shardInstanceManager {
    static ZJJLocationNotiManager *appdelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appdelegate = [[ZJJLocationNotiManager alloc] init];
    });
    return appdelegate;
}

- (void)addNotiWithID:(NSString *)notiID title:(NSString *)title subTitle:(NSString *)subTitle bodyString:(NSString *)bodyString howManySecondsToTrigger:(NSTimeInterval)seconds {
    UNUserNotificationCenter *notiCenter = [UNUserNotificationCenter currentNotificationCenter];
    notiCenter.delegate = (id<UNUserNotificationCenterDelegate>) self;
    [notiCenter requestAuthorizationWithOptions:UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"请求权限成功");
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = title;
            content.subtitle = subTitle;
            content.body = bodyString;
            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:seconds repeats:NO];
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:notiID content:content trigger:trigger];
            [notiCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    NSLog(@"添加成功");
                }
            }];
        } else {
            NSLog(@"请求权限失败");
            [self showGoToSettingsPageAlertView];
        }
    }];
}

- (void)showGoToSettingsPageAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"APP接收通知权限未开" message:@"是否去设置界面打开权限?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍候去" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    UIViewController *rootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    dispatch_async(dispatch_get_main_queue(), ^{
        [rootVC presentViewController:alert animated:YES completion:nil];        
    });
}

- (void)removeLocalNotificationWithIDArray:(NSArray *)identifierArray {
    UNUserNotificationCenter *notiCenter = [UNUserNotificationCenter currentNotificationCenter];
    [notiCenter removePendingNotificationRequestsWithIdentifiers:identifierArray];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    completionHandler();
}

@end
