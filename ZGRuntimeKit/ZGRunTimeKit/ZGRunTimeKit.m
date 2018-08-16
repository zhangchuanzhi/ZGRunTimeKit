//
//  ZGRunTimeKit.m
//  ZGRuntimeKit
//
//  Created by offcn_zcz32036 on 2018/8/15.
//  Copyright © 2018年 cn. All rights reserved.
//

#import "ZGRunTimeKit.h"

@implementation ZGRunTimeKit
/**
 获取类名

 @param ocClass 相应类
 @return 类名
 */
+(NSString*)fetchClassName:(Class)ocClass
{
    const char*className=class_getName(ocClass);
    return [NSString stringWithUTF8String:className];
}
/**
 获取成员变量

 @param ocClass 成员变量所在的类
 @return 返回成员变量字符串数组
 */
+(NSArray*)fetchIvarList:(Class)ocClass{
    unsigned int count=0;
    Ivar*ivarList=class_copyIvarList(ocClass, &count);
    NSMutableArray*mutableList=[NSMutableArray arrayWithCapacity:count];
    for (unsigned int i=0; i<count; i++) {
        NSMutableDictionary*dic=[NSMutableDictionary dictionaryWithCapacity:2];
        const char*ivarName=ivar_getName(ivarList[i]);
        const char*ivarType=ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"]=[NSString stringWithUTF8String:ivarType];
        dic[@"ivarName"]=[NSString stringWithUTF8String:ivarName];
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}
/**
 获取类的属性列表，包括私有和公有属性，即定义在延展中的属性

 @param ocClass class
 @return 属性列表数组
 */
+(NSArray*)fetchPropertyList:(Class)ocClass{
    unsigned int count=0;
    objc_property_t*propertyList=class_copyPropertyList(ocClass, &count);
    NSMutableArray*mutableList=[NSMutableArray arrayWithCapacity:count];
    for (unsigned int i=0; i<count; i++) {
        const char*propertyName=property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}
/**
 获取对象方法列表，getter,setter,对象方法等，但不能获取类方法

 @param ocClass 方法所在的类
 @return 该类的方法列表
 */
+(NSArray*)fetchMethodList:(Class)ocClass{
    unsigned int count=0;
    Method*methodList=class_copyMethodList(ocClass, &count);
    NSMutableArray*mutableList=[NSMutableArray arrayWithCapacity:count];
    for (unsigned int i=0; i<count; i++) {
        Method method=methodList[i];
        SEL methodName=method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}
/**
 获取协议列表

 @param ocClass 实现协议的类
 @return 返回该类实现的协议列表
 */
+(NSArray*)fetchProtocolList:(Class)ocClass{
    unsigned int count=0;
    __unsafe_unretained Protocol **protocolList=class_copyProtocolList(ocClass, &count);
    NSMutableArray*mutableList=[NSMutableArray arrayWithCapacity:count];
    for (unsigned int i=0; i<count; i++) {
        Protocol*protocol=protocolList[i];
        const char*protocolName=protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:mutableList];
}
/**
 添加新的方法

 @param ocClass 被添加方法的类
 @param methodSel SEL
 @param methodSelImpl 提供IMP的SEL
 */
+(void)addMethod:(Class)ocClass method:(SEL)methodSel method:(SEL)methodSelImpl{
    Method method=class_getInstanceMethod(ocClass, methodSelImpl);
    IMP methodIMP=method_getImplementation(method);
    const char*types=method_getTypeEncoding(method);
    class_addMethod(ocClass, methodSel, methodIMP, types);
}
/**
 方法交换

 @param ocClass 交换方法所在的类
 @param method1 方法1
 @param method2 方法2
 */
+(void)methodSwap:(Class)ocClass firstMethod:(SEL)method1 secondMethod:(SEL)method2{
    Method firstMethod=class_getInstanceMethod(ocClass, method1);
    Method secondMethod=class_getInstanceMethod(ocClass, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}
@end
