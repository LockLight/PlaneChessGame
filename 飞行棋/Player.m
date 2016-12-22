//
//  Player.m
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import "Player.h"

@implementation Player

/**
 *  玩家掷骰子
 *
 *  @return 骰子点数=玩家行走的步数
 */
- (int)playDice{
    int step = arc4random_uniform(6)+1;
    return step;
}
/**
 *  玩家前进方法
 *
 *  @param step 前进步数
 *
 *  @return 移动后的玩家位置
 */
- (void)moveForWordWith:(int)step{
    _position += step;
    single *singleGate = [single shareSingle];
    //判断越界
    if (_position > singleGate.mapLength-1) {
        _position = singleGate.mapLength-1;
    }
}
/**
 *  玩家后退方法
 *
 *  @param step 后退步数
 *
 *  @return 移动后的玩家位置
 */
- (void)moveBackWith:(int)step{
    _position -= step;
    //判断越界
    if (_position < 0) {
        _position = 0;
    }
}

/**
 *  工程方法
 *
 *  @param name 玩家姓名
 *  @param sign 玩家标识
 *
 *  @return 初始化完成的玩家对象
 */
- (instancetype)initWithName:(NSString *)name andSign:(NSString *)sign{
    self = [super init];
    if (self) {
        self.name = name;
        self.sign = sign;
    }
    return self;
}

+ (instancetype)playerWithName:(NSString *)name andSign:(NSString *)sign
{
    return [[self alloc] initWithName:name andSign:sign];
}


@end
