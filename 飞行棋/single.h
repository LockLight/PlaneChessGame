//
//  single.h
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  单例类,储存需要共享数据
 */
@interface single : NSObject

@property(nonatomic,assign)int mapLength;     //地图长度
@property(nonatomic,assign)int bombCount;     //炸弹数量
@property(nonatomic,assign)int bigPlaneCount;  //飞机数量
@property(nonatomic,assign)int redGreenLightCount;  //红绿灯数量
@property(nonatomic,assign)int luckyTurnCount;   //幸运转盘数量
/**
 *  工厂方法
 *
 *  @return 返回单例类对象
 */
+ (instancetype)shareSingle;

@end
