//
//  main.m
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameController.h"

int main(int argc, const char * argv[]) {
    GameController *gameController = [GameController gameController];
    [gameController startGame];
    return 0;
}
