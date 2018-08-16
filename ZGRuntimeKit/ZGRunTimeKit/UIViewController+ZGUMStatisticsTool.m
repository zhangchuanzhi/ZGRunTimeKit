//
//  UIViewController+ZGUMStatisticsTool.m
//  ZGRuntimeKit
//
//  Created by offcn_zcz32036 on 2018/8/16.
//  Copyright © 2018年 cn. All rights reserved.
//

#import "UIViewController+ZGUMStatisticsTool.h"
#import "UMMobClick/MobClick.h"
#import "ZGRunTimeKit.h"
@implementation UIViewController (ZGUMStatisticsTool)
+(void)load
{
    //交换新的方法
    [ZGRunTimeKit methodSwap:[self class] firstMethod:@selector(viewWillAppear:) secondMethod:@selector(zg_viewWillAppear:)];
    [ZGRunTimeKit methodSwap:[self class] firstMethod:@selector(viewWillDisappear:) secondMethod:@selector(zg_ViewWillDisAppear:)];
}
-(void)zg_viewWillAppear:(BOOL)animated
{
    [self zg_viewWillAppear:animated];
    //开始友盟页面统计
    [MobClick beginLogPageView:[ZGRunTimeKit fetchClassName:[self class]]];
}
-(void)zg_ViewWillDisAppear:(BOOL)animated
{
    [self zg_ViewWillDisAppear:animated];
    //结束友盟页面统计
    [MobClick endLogPageView:[ZGRunTimeKit fetchClassName:[self class]]];
}
@end
