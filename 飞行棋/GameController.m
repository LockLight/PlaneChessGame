//
//  GameController.m
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import "GameController.h"
#import "Player.h"
#import "single.h"
#define sleepTime 0.18

@interface GameController()

@property (nonatomic,strong)MapData *mapData;
@property (nonatomic,strong)GameView *gameView;
@property (nonatomic,strong)NSMutableArray *players;

- (void)showLogo;
- (void)initPlayers;

/**
    当玩家位置处于各种类型关卡时响应的方法
 */
- (void)meetBomb:(Player *)player;
- (void)meetBigPlane:(Player *)player;
- (void)meetRedGreenLight:(Player *)player;
- (void)meetLuckyTurn:(Player *)player;

@end

@implementation GameController


- (instancetype)init{
    if (self = [super init]) {
        //初始化游戏控制器的管理的3个对象
        self.mapData = [MapData mapData];
        self.gameView = [GameView GameViewWithMapData:_mapData];
        self.players  = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)gameController{
    return [[self alloc]init];
}


- (void)startGame{
    //1.清屏.
    [_gameView clearView];
    //2.显示Logo
    [self showLogo];
    //3.初始化玩家信息.
    [self initPlayers];
    //4.显示游戏地图.
    [_gameView showMapWith:_players];
    //5.两个玩家循环掷骰子
    while (1)
    {
        for(Player *player in _players)
        {
            if (player.isStop == NO) {
                
                //这个迭代变量player就是数组中的每一个玩家对象.
                //1.提示玩家按任意键掷骰子.
                NSString *msg = [NSString stringWithFormat:@"玩家%@:%@请按下回车键开始掷骰子\n.",player.sign,player.name];
                [_gameView writeString:msg];
                //2.等待用户按下回车键.
                [_gameView waitEnter];
                //3.让当前玩家掷骰子
                int diceNum =  [player playDice];
                //4.显示玩家扔的点数.
                msg = [NSString stringWithFormat:@"玩家%@:%@你扔的点数是[%d]请按回车键开始移动\n",player.sign,player.name,diceNum];
                [_gameView writeString:msg];
                //5.等待回车键
                [_gameView waitEnter];
                //            //6.玩家移动.
                //            [player moveForWordWith:diceNum];
                //动态移动
                for (int i = 0; i<diceNum; i++) {
                    player.position++;
                    //7.刷新地图.
                    [_gameView clearView];
                    [self showLogo];
                    [_gameView showMapWith:_players];
                    [NSThread sleepForTimeInterval:sleepTime];
                }
                //以玩家的位置为下标 取出_data数组中元素的值 这个元素的值就是玩家所在的格子的类型.
                NSNumber *number = self.mapData.data[player.position];
                //根据下标的值,选择相应格子类型,并反映不同方法
                    switch (number.intValue) {
                        case gateTypeBomb:
                            [self meetBomb:player];
                            break;
                        case gateTypeBigPlane:
                            [self meetBigPlane:player];
                            break;
                        case gateTypeRedGreenLight:
                            [self meetRedGreenLight:player];
                            break;
                        case gateTypeLuckyTurn:
                            [self meetLuckyTurn:player];
                            break;
                    }
            }else{
                player.stop = NO;
            }
            //掷完骰子后,判断当前玩家位置是否在终点并结束游戏
            if (player.position == [single shareSingle].mapLength -1 ) {
                NSString *msg = [NSString stringWithFormat:@"玩家%@:%@率先到达终点,游戏结束\n",player.name,player.sign];
                [_gameView writeString:msg];
                return;
            }
        }
    }
}
/**
 *  显示游戏Logo
 */
- (void)showLogo{
    [_gameView writeString:@"##############################################\n"];
    [_gameView writeString:@"#       终 端 程 序   Objective-C语言        #\n"];
    [_gameView writeString:@"#                飞 行 棋 项 目              #\n"];
    [_gameView writeString:@"#   💣 炸弹  ✈️ 大飞机  🚥 红绿灯  🎆 幸运轮盘   #\n"];
    [_gameView writeString:@"##############################################\n"];
}
/**
 *  初始化玩家信息
 */
- (void)initPlayers{
    //1. 先提示用户输入第一个玩家的姓名.
    //   玩家姓名不能为空 长度不小于4
    //   如果姓名合法 创建玩家对象 存储到players数组中.
    [_gameView writeString:@"请输入第一个玩家的姓名\n"];
    //2. 从游戏界面接收玩家输入姓名.
    NSString *nameA;
    while(1){
    nameA  = [_gameView readString];
    //消除字符串前后空格
    nameA  = [nameA stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //3. 判断玩家1的姓名是否合法.
        if (nameA.length == 0) {
            [_gameView writeString:@"玩家1姓名不能为空,请重新输入"];
        }else if(nameA.length <4){
            [_gameView writeString:@"玩家1姓名长度不能小于4,请重新输入"];
        }else{
            //玩家1的姓名合法
            //1.创建玩家对象.并初始化玩家对象.
            Player *player = [Player playerWithName:nameA andSign:@"1️⃣ "];
            //2.把这个玩家对象存储到players数组中.
            [_players addObject:player];
            //3.提示玩家1的姓名初始化成功
            [_gameView writeString:@"玩家1姓名初始化完成,请按回车继续\n"];
            //4. 让程序暂停.按回车键的时候才继续.
            [_gameView waitEnter];
            //5. 按下回车键之后,清屏 显示Logo
            [_gameView clearView];
            [self showLogo];
            break;
        }
    }
    //接收玩家2姓名
    [_gameView writeString:@"请输入第二个玩家的姓名\n"];
    while (1) {
        NSString *nameB = [_gameView readString];
        nameB = [nameB stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (nameB.length == 0) {
            [_gameView writeString:@"玩家2姓名不能为空,请重新输入"];
        }else if(nameB.length <4){
            [_gameView writeString:@"玩家2姓名长度不能小于4,请重新输入"];
        }else{
            //判断是否重名
            BOOL res = [nameB isEqualToString:nameA];
            if (res == YES) {
                [_gameView writeString:@"玩家2姓名与玩家1一致,请重新输入"];
                continue;
            }
            Player *player = [Player playerWithName:nameB andSign:@"2️⃣ "];
            [_players addObject:player];
            [_gameView writeString:@"玩家2姓名初始化成功,请按回车继续\n"];
            [_gameView waitEnter];
            [_gameView clearView];
            [self showLogo];
            break;
        }
    }
}

- (void)meetBomb:(Player *)player{
    //提示
    NSString *msg = [NSString stringWithFormat:@"玩家%@:%@,很遗憾,你遇见了地雷,将退后6格,请按回车继续\n"
                     ,player.sign,player.name];
    [_gameView writeString:msg];
    //等待回车
    [_gameView waitEnter];
    for (int i =0; i< 6; i++) {
        player.position--;
        if (player.position < 0) {
            player.position = 0;
        }
        //刷新地图
        [_gameView clearView];
        [self showLogo];
        [_gameView showMapWith:_players];
        [NSThread sleepForTimeInterval:sleepTime];
    }
}
- (void)meetBigPlane:(Player *)player{
    //提示
    NSString *msg = [NSString stringWithFormat:@"玩家%@:%@,很幸运,你遇见了飞机,将前进10格,请按回车继续\n"
                     ,player.sign,player.name];
    [_gameView writeString:msg];
    //等待回车
    [_gameView waitEnter];
    for (int i =0; i< 10; i++) {
        player.position++;
        //刷新地图
        [_gameView clearView];
        [self showLogo];
        [_gameView showMapWith:_players];
        [NSThread sleepForTimeInterval:sleepTime];
    }
}
- (void)meetRedGreenLight:(Player *)player{
    //提示
    NSString *msg = [NSString stringWithFormat:@"玩家%@:%@,很抱歉,你遇见了红绿灯,将暂停行动一回合,请按回车继续\n"
                     ,player.sign,player.name];
    [_gameView writeString:msg];
    //等待回车
    [_gameView waitEnter];
    //暂停一回合
    player.stop = YES;
}
- (void)meetLuckyTurn:(Player *)player{
    //提示
    NSString *msg = [NSString stringWithFormat:@"玩家%@ : %@ 你遇到了幸运之转盘,可以满足你一个愿望\n     1. 灵魂互换    2.轰炸对方\n   请选择:.",
                     player.sign,player.name];
    [_gameView writeString:msg];
    //接收用户选择
    NSString *userSelect = [_gameView readString];
    //根据选择判断
    if ([userSelect isEqualToString:@"1"]) {
        msg = [NSString stringWithFormat:@"玩家%@:%@,你选择了灵魂互换,请按回车继续\n",player.sign,player.name];
        [_gameView writeString:msg];
        [_gameView waitEnter];
        //创建两个玩家对象,并指定它在数组中的下标
        Player *p1 = _players.firstObject;
        Player *p2 = _players.lastObject;
        //交换位置
//        int temp = p1.position;
//        p1.position = p2.position;
//        p2.position = temp;
        [_players exchangeObjectAtIndex:p1.position withObjectAtIndex:p2.position];
    }else{
        msg = [NSString stringWithFormat:@"玩家%@:%@,你选择了轰炸对方,对方将回退6格,请按回车继续\n",player.sign,player.name];
        [_gameView writeString:msg];
        [_gameView waitEnter];
        //创建对方玩家,并判断在数组中的下标位置
        Player *otherPlayer = (player == _players.firstObject ? _players.lastObject: _players.firstObject);
        [otherPlayer moveBackWith:6];
    }
    //4.刷新地图
    [_gameView clearView];
    [self showLogo];
    [_gameView showMapWith:_players];
}
@end
