//
//  ZGRunTimeKit.h
//  ZGRuntimeKit
//
//  Created by offcn_zcz32036 on 2018/8/15.
//  Copyright © 2018年 cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
@interface ZGRunTimeKit : NSObject
/**
 获取类名

 @param ocClass 相应类
 @return 类名
 */
+(NSString*)fetchClassName:(Class)ocClass;
/**
 获取成员变量

 @param ocClass 成员变量所在的类
 @return 返回成员变量字符串数组
 */
+(NSArray*)fetchIvarList:(Class)ocClass;
/**
 获取类的属性列表，包括私有和公有属性，即定义在延展中的属性

 @param ocClass class
 @return 属性列表数组
 */
+(NSArray*)fetchPropertyList:(Class)ocClass;
/**
 获取对象方法列表，getter,setter,对象方法等，但不能获取类方法

 @param ocClass 方法所在的类
 @return 该类的方法列表
 */
+(NSArray*)fetchMethodList:(Class)ocClass;
/**
 获取协议列表

 @param ocClass 实现协议的类
 @return 返回该类实现的协议列表
 */
+(NSArray*)fetchProtocolList:(Class)ocClass;
/**
 添加新的方法

 @param ocClass 被添加方法的类
 @param methodSel SEL
 @param methodSelImpl 提供IMP的SEL
 */
+(void)addMethod:(Class)ocClass method:(SEL)methodSel method:(SEL)methodSelImpl;
/**
 方法交换

 @param ocClass 交换方法所在的类
 @param methods 方法1
 @param method2 方法2
 */
+(void)methodSwap:(Class)ocClass firstMethod:(SEL)method1 secondMethod:(SEL)method2;
@end
