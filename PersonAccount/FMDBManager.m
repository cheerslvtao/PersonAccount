//
//  FMDBManager.m
//  PersonAccount
//
//  Created by 吕涛 on 2017/3/2.
//  Copyright © 2017年 Lvtao. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDatabase.h"

@implementation FMDBManager
{
    FMDatabase * _listdb;
    FMDatabase * _itemdb;
}

+(FMDBManager *)defaultFMDBManager {
    static FMDBManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc]init];
    });
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString * listFile = @"Documents/accountList.db";
        NSString * itemFile = @"Documents/items.db";
        NSString * listpath = [NSHomeDirectory() stringByAppendingString:listFile];
        NSString * itempath = [NSHomeDirectory() stringByAppendingString:itemFile];
        
        if (_listdb == nil || _itemdb == nil) {
            _listdb = [FMDatabase databaseWithPath:listpath];
            _itemdb = [FMDatabase databaseWithPath:itempath];
        }
        
        if ([_itemdb open] && [_listdb open]) {
            [self createTable:_listdb tableName:@"ACCOUNTLIST" parameter:@[]]; //首页列表
            [self createTable:_itemdb tableName:@"INCOMETABLE" parameter:@[]]; //收入选项
            [self createTable:_itemdb tableName:@"EXPENDTABLE" parameter:@[]]; //支出选项
        }
    }
    return self;
}

-(void)createTable:(FMDatabase *)targetDatabase tableName:(NSString *)name parameter:(NSArray *)parameterArr {
    NSString * sq = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXEXISTS %@(id integer primary key autoincrement",name];
    
    for (int i = 0; i<parameterArr.count; i++) {
        NSString * str = [NSString stringWithFormat:@",%@ text",parameterArr[i]];
        if (i == parameterArr.count-1) {
            str = [str stringByAppendingString:@")"];
        }
        sq = [sq stringByAppendingString:str];
    }
    
    if ([targetDatabase executeUpdate:sq]) {
        NSLog(@"创建表成功");
    }
}







@end


