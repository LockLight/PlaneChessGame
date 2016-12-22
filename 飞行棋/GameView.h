//
//  GameView.h
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapData.h"

//宏定义NSLog  忽略调试信息,不会自动换行
#define NSLog(FORMAT, ...) printf("%s", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

/**
 *  游戏视图类:负责显示,输入和输出
 */
@interface GameView : NSObject
/**
 *  被游戏视图管理的地图数据,存储地图的数据信息
 */
@property(nonatomic,strong)MapData *mapData;
/**
 *  初始化地图属性
 *
 *  @param mapData 地图数据
 *
 *  @return 初始化完成的对象
 */
- (instancetype)initWithMapData:(MapData *)mapData;
+ (instancetype)GameViewWithMapData:(MapData *)mapData;

//显示地图
- (void)showMap;
//清屏
- (void)clearView;
/**
 *  打印当前View输出信息(字符串)
 *
 *  @param strContent 字符串内容
 */
- (void)writeString:(NSString *)strContent;
/**
 *  接收玩家输入字符串
 *
 *  @return 字符串类型
 */
- (NSString *)readString;

- (void)waitEnter;

@end
