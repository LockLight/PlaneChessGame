//
//  GameController.h
//  飞行棋
//
//  Created by locklight on 16/12/21.
//  Copyright © 2016年 locklight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapData.h"
#import "GameView.h"

@interface GameController : NSObject

- (void)startGame;

+ (instancetype)gameController;
@end