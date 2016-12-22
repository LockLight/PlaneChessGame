//
//  MapData.h
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.


#import <Foundation/Foundation.h>

/**
 地图关卡枚举类型
 */
typedef enum {
    gateTypeBlank = 0,
    gateTypeBomb = 1,
    gateTypeBigPlane = 2,
    gateTypeRedGreenLight = 3,
    gateTypeLuckyTurn = 4,
}gateType;


/**
 *  地图数据类
 */
@interface MapData : NSObject
/**
 *  地图关卡数据,存储关卡枚举类型元素
 */
@property(nonatomic,strong)NSMutableArray *data;

/**
 *  初始化地图
 *
 *  @return 地图类对象
 */
+ (instancetype)mapData;

@end
