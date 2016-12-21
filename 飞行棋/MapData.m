//
//  MapData.m
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import "MapData.h"
#import "single.h"


@interface MapData()
/**
 *  设置随机关卡的方法
 *
 *  @param type  关卡类型
 *  @param count 关卡数量
 */
- (void)setGate:(gateType)type andCount:(int)count;

@end

@implementation MapData

/**
 *  初始化地图
 *
 *  @return 地图类对象
 */
+ (instancetype)mapData;{
    return [[self alloc]init];
}
/**
    初始化对象属性,创建时即生成需要的属性
 */
- (instancetype)init{
    if (self = [super init]) {
        //初始化_data属性的数组元素
        self.data = [NSMutableArray array];
        //创建单例对象,共享其属性mapLength
        single *singleGate = [single shareSingle];
        //向数组中添加普通关卡类型的元素
        for (int i =0; i<singleGate.mapLength;i++) {
            [_data addObject:@(gateTypeBlank)];
        }
        //设置不同类型关卡
        [self setGate:gateTypeBomb andCount:singleGate.bombCount];
        [self setGate:gateTypeBigPlane andCount:singleGate.bigPlaneCount];
        [self setGate:gateTypeRedGreenLight andCount:singleGate.redGreenLightCount];
        [self setGate:gateTypeLuckyTurn andCount:singleGate.luckyTurnCount];
    }
    return self;
}
/**
 *  设置随机关卡的方法
 *
 *  @param type  关卡类型
 *  @param count 关卡数量
 */
- (void)setGate:(gateType)type andCount:(int)count{
    single *singleGate = [single shareSingle];
    for(int i = 0;i<count;){
        //产生随机下标
        int index = arc4random_uniform(singleGate.mapLength -2 ) +1;
        //判断下标是是否重复
        NSNumber *number = _data[index];
        if (number.integerValue == gateTypeBlank) {
            self.data[index] = @(type);
            i++;
        }
    }
}
@end







