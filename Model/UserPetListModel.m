//
//  UserPetListModel.m
//  MyPetty
//
//  Created by miaocuilin on 14-9-5.
//  Copyright (c) 2014年 AidiGame. All rights reserved.
//

#import "UserPetListModel.h"

@implementation UserPetListModel

-(void)dealloc{
    [_aid release];
    [_d_rq release];
    [_fans_count release];
    [_name release];
    [_news_count release];
    [_rank release];
    [_t_contri release];
    [_tx release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    NSLog(@"key:%@未赋值", key);
}
@end