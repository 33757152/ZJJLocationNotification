//
//  RootViewController.m
//  ZJJLocationNotification
//
//  Created by admin on 2020/12/29.
//

#import "RootViewController.h"
#import "ZJJLocationNotiManager.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[ZJJLocationNotiManager shardInstanceManager] addNotiWithID:@"hello" title:@"我是标题" subTitle:@"我是副标题" bodyString:@"我是内容" howManySecondsToTrigger:10];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
