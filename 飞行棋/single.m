//
//  single.m
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import "single.h"

@implementation single
/**
 *  初始化对象
 *
 *  @return 对象本身
 */

- (instancetype)init{
    if (self = [super init]) {
        self.mapLength = 96;
        self.bombCount = 40;
        self.bigPlaneCount = 10;
        self.redGreenLightCount = 10;
        self.luckyTurnCount = 30;
    }
    return self;
}
/**
 *  工厂方法
 *
 *  @return 返回单例类对象
 */
+ (instancetype)shareSingle{
    return [[self alloc]init];
}
/**
 重写方法,实现单例
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static id instance = nil;
    if (instance == nil) {
        instance = [super allocWithZone:zone];
    }
    return instance;
}
@end
