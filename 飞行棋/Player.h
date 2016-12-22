//
//  Player.h
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "single.h"
/**
 *  玩家类
 */
@interface Player : NSObject
/**
 *  玩家姓名
 */
@property(nonatomic,copy)NSString *name;
/**
 *  玩家在地图上的位置
 */
@property(nonatomic,assign)int position;
/**
 *  玩家在地图上的标识
 */
@property(nonatomic,copy)NSString *sign;
/**
 *  玩家是否在地图上暂停,缺省值为否
 */
@property(nonatomic,assign,getter=isStop)BOOL stop;


- (int)playDice;
- (void)moveForWordWith:(int)step;
- (void)moveBackWith:(int)step;
/**
 *  工程方法
 *
 *  @param name 玩家姓名
 *  @param sign 玩家标识
 *
 *  @return 初始化完成的玩家对象
 */
- (instancetype)initWithName:(NSString *)name andSign:(NSString *)sign;

+ (instancetype)playerWithName:(NSString *)name andSign:(NSString *)sign;

@end
