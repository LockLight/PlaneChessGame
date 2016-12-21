//
//  GameView.m
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import "GameView.h"

@interface GameView()

// 根据地图下标元素的值打印关卡
- (NSString *)mapString:(int)index;

@end

@implementation GameView

- (instancetype)initWithMapData:(MapData *)mapData{
    if (self = [super init]) {
        self.mapData = mapData;
    }
    return self;
}
+ (instancetype)GameViewWithMapData:(MapData *)mapData{
    return [[self alloc]initWithMapData:mapData];
}

- (NSString *)mapString:(int)index{
    //默认是普通关卡
    NSString *mapString = @"🍎 ";
    //根据下标取出对象关卡元素的值
    NSNumber *number = [_mapData.data objectAtIndex:index];
    switch (number.intValue) {
        case gateTypeBomb:
            mapString = @"💣 ";
            break;
        case gateTypeLuckyTurn:
            mapString = @"🎆 ";
            break;
        case gateTypeRedGreenLight:
            mapString = @"🚥 ";
            break;
        case gateTypeBigPlane:
            mapString = @"✈️ ";
            break;
    }
    return mapString;
}


- (void)showMap{
    //打印第一组
    for (int i = 0; i<30; i++) {
        //取出_data数组中对应下标元素的值
        NSString *mapString =[self mapString:i];
        //根据值显示不同的关卡
        NSLog(@"%@",mapString);
    }
    NSLog(@"\n");
    //打印第二组
    for (int i = 30; i<33; i++) {
        for (int j= 0; j<29*2; j++) {
            NSLog(@" ");
        }
        NSString *mapString =[self mapString:i];
        NSLog(@"%@\n",mapString);
    }
    //打印第三组
    for (int i = 62; i>=33; i--) {
        NSString *mapString =[self mapString:i];
        NSLog(@"%@",mapString);
    }
    NSLog(@"\n");
    //打印第四组
    for (int i = 63; i<66; i++) {
        NSString *mapString =[self mapString:i];
        NSLog(@"%@\n",mapString);
    }
    //打印第五组
    for (int i = 66; i<96; i++) {
        NSString *mapString =[self mapString:i];
        NSLog(@"%@",mapString);
    }
    NSLog(@"\n");
}

- (void)clearView{
    system("clear");
}

- (void)writeString:(NSString *)strContent{
    NSLog(@"%@",strContent);
}

- (NSString *)readString{
    char input[20];
    rewind(stdin);
    fgets(input, 20, stdin);
    size_t len = strlen(input);
    if (input[len-1] == '\n') {
        input[len-1] = '\0';
    }
    rewind(stdin);
    return [NSString stringWithUTF8String:input];
}

- (void)waitEnter{
    char input[20];
    rewind(stdin);
    fgets(input, 20,stdin);
    rewind(stdin);
}


@end
