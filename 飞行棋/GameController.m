//
//  GameController.m
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import "GameController.h"
#import "Player.h"

@interface GameController()

@property (nonatomic,strong)MapData *mapData;
@property (nonatomic,strong)GameView *gameView;
@property (nonatomic,strong)NSMutableArray *players;

@end

@implementation GameController


- (instancetype)init{
    if (self = [super init]) {
        self.mapData = [MapData mapData];
        self.gameView = [GameView GameViewWithMapData:_mapData];
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
    [_gameView showMap];
    
}
/**
 *  显示游戏Logo
 */
- (void)showLogo{
    [_gameView writeString:@"##############################################\n"];
    [_gameView writeString:@"#       黑  马  程  序  员  iOS  学  院      #\n"];
    [_gameView writeString:@"#              OOP 飞 行 棋 项 目            #\n"];
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
            Player *player = [Player playerWithName:nameA andSign:@"1⃣"];
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
    [_gameView writeString:@"请输入第2个玩家的姓名\n"];
    while (1) {
        NSString *nameB = [_gameView readString];
        nameB = [nameB stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (nameB.length == 0) {
            [_gameView writeString:@"玩家2姓名不能为空,请重新输入"];
        }else if(nameB.length <4){
            [_gameView writeString:@"玩家2姓名长度不能小于4,请重新输入"];
        }else{
            BOOL res = [nameB isEqualToString:nameA];
            if (res == YES) {
                [_gameView writeString:@"玩家2姓名与玩家1一致,请重新输入"];
                continue;
            }
            Player *player = [Player playerWithName:nameB andSign:@"2⃣"];
            [_players addObject:player];
            [_gameView writeString:@"玩家2姓名初始化成功,请按回车继续\n"];
            [_gameView waitEnter];
            [_gameView clearView];
            [self showLogo];
            break;
        }
    }
}

@end
