//
//  ZJJLocationNotiManager.h
//  ZJJLocationNotification
//
//  Created by admin on 2020/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJJLocationNotiManager : NSObject

/// 创建单例
+ (instancetype)shardInstanceManager;

/// 添加通知
- (void)addNotiWithID:(NSString *)notiID title:(NSString *)title subTitle:(NSString *)subTitle bodyString:(NSString *)bodyString howManySecondsToTrigger:(NSTimeInterval)seconds;

/// 移除对应ID的通知
- (void)removeLocalNotificationWithIDArray:(NSArray *)identifierArray;

@end

NS_ASSUME_NONNULL_END
