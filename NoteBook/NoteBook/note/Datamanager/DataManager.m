//
//  DataManager.m
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "DataManager.h"

static DataManager *_mainDataBase = nil;
//#define INSERTTABLE     @"INSERT INTO ADDRESS VALUES(?,?,?,?)"
#define INSERTTABLE     @"INSERT INTO WeeklyDB (weeklyid,username,uid,title,content,createtime,updatetime,isblog,blogurl,groupid)VALUES(?,?,?,?,?,?,?,?,?,?);"
//#define UPDATETABLE     @"UPDATE ADDRESS SET INDEXS = ?,NAME = ?,TEL = ?,FAVORITE = ? WHERE ROWID = ?;"
#define UPDATETABLE     @"UPDATE WeeklyDB SET weeklyid = ?,username = ?,uid = ?,title = ? ,content = ?,createtime = ?,updatetime = ? ,isblog = ?,blogurl = ?,groupid = ? WHERE weeklyid = ?;"
#define DELETETABLE     @"DELETE FROM WeeklyDB WHERE ROWID = ?;"
#define SELECTROWID     @"SELECT *FROM WeeklyDB WHERE weeklyid = ?;"
#define SELECTWEEKLYID     @"SELECT * FROM WeeklyDB WHERE weeklyid = ?;"

#define MAXSECTION 27

@interface DataManager ()

@property (nonatomic,strong) NSMutableDictionary *indexDict;

@end


@implementation DataManager
+ (instancetype)shareDataBase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_mainDataBase == nil) {
            _mainDataBase = [DataManager createAddressDataBase];
//            _mainDataBase.indexDict = [[NSMutableDictionary alloc] init];
//            _mainDataBase.seaechResult = [[NSMutableArray alloc] init];
//            _mainDataBase.favoriteResult = [[NSMutableArray alloc] init];
//            _mainDataBase.indexTitle = [_mainDataBase createIndexTitle];
            [_mainDataBase createMyTable];
        }
    });
    return _mainDataBase;
}
+ (instancetype)createAddressDataBase
{
    NSArray *arry = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/WeeklyDB.sqlite",arry[0]];
    NSLog(@"%@",path);
    return [DataManager databaseWithPath:path];
}
- (void)createMyTable
{
    [self open];
    NSString *address =  @"CREATE TABLE IF NOT EXISTS WeeklyDB(\
    weeklyid TEXT , "
    @"username TEXT , "
    @"uid TEXT, "
    @"title TEXT, "
    @"content TEXT, "
    @"createtime TEXT, "
    @"updatetime TEXT, "
    @"isblog TEXT, "
    @"blogurl TEXT, "
    @"groupid TEXT);";
    [self executeUpdate:address];
    [self close];
}
/**
 *  构建分区列表
 */
- (NSArray *)createIndexTitle
{
    NSInteger index = 0;
    NSString *indexStr;
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    for (; index < MAXSECTION; index ++) {
        if (index == 0) {
            indexStr = @"~";
        }else
        {
            char ch = 'A'+index-1;
            indexStr = [NSString stringWithFormat:@"%c",ch];
        }
        [arry addObject:indexStr];
    }
    return [NSArray arrayWithArray:arry];
}
/**
 *  数据索引的构建
 */
- (void)indexOfAllDatabase
{
    NSInteger index = 0;
    NSString *indexStr;
    [self open];
    [_indexDict removeAllObjects];
    for (; index < MAXSECTION; index ++) {
        NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
        indexStr = [_indexTitle objectAtIndex:index];
        NSString *temp = [NSString stringWithFormat:@"SELECT ROWID  FROM ADDRESS WHERE INDEXS == '%@' ORDER BY NAME;",[NSString stringWithFormat:@"%@",indexStr]];
        FMResultSet *set = [self executeQuery:temp];
        NSInteger count = 0;
        while ([set next]) {
            NSNumber *key = [NSNumber numberWithInteger:count];
            NSNumber *rowid = [NSNumber numberWithInteger:[set intForColumn:@"ROWID"]];
            count ++;
            [dict setObject:rowid forKey:key];
        };
        [_indexDict setObject:dict forKey:indexStr];
    }
    [self close];
}
//插入数据
- (BOOL)insertIntoDBWithItem:(SWGWeekly *)weekly;
{
    [self open];
    NSString *insertSql = INSERTTABLE;
//    NSNumber *num = [NSNumber numberWithInteger:weekly.weeklyid.integerValue];
    if ([self executeUpdate:insertSql,weekly.weeklyid,weekly.username,weekly.uid,weekly.title,weekly.content,
         weekly.createtime,weekly.updatetime ,weekly.isblog ,weekly.blogurl ,weekly.groupid]) {
        [self close];
        return YES;
    }else
    {
        [self close];
        return NO;
    }
}
- (BOOL)updateItemWithWeekly:(SWGWeekly *)weekly
{
    [self open];
    NSNumber *num = [NSNumber numberWithInteger:weekly.weeklyid.integerValue];
    NSString *updateSql = UPDATETABLE;
    if ([self executeUpdate:updateSql,weekly.weeklyid,weekly.username,weekly.uid,weekly.title,weekly.content,
         weekly.createtime,weekly.updatetime ,weekly.isblog ,weekly.blogurl ,weekly.groupid,num]) {
        [self close];
        return YES;
    }else
    {
        [self close];
        return NO;
    }
}
- (SWGWeekly *)returnWeeklyById:(NSString *)weeklyid{
    [self open];
    NSString *str = [NSString stringWithFormat:SELECTWEEKLYID];
    NSNumber *num = [NSNumber numberWithInteger:weeklyid.integerValue];
    FMResultSet *set = [self executeQuery:str,num];
    SWGWeekly *item = [self makeItemWithResultSet:set];
    [self close];
    return item;
}
//将结果集转化为数据实体
- (SWGWeekly *)makeItemWithResultSet:(FMResultSet *)set
{
    SWGWeekly *weekly = [[SWGWeekly alloc] init];
    while ([set next]) {
        weekly.weeklyid = [set stringForColumn:@"weeklyid"];
        weekly.username = [set stringForColumn:@"username"];
        weekly.uid = [set stringForColumn:@"uid"];
        weekly.title = [set stringForColumn:@"title"];
        weekly.content = [set stringForColumn:@"content"];
        
        weekly.createtime = [set stringForColumn:@"createtime"];
        weekly.updatetime = [set stringForColumn:@"updatetime"];
        weekly.isblog = [set stringForColumn:@"isblog"];
        weekly.blogurl = [set stringForColumn:@"blogurl"];
        weekly.groupid = [set stringForColumn:@"groupid"];
    }
    return weekly;
}





















//- (NSString *)getIndexForweekly:(SWGWeekly *)weekly
//{
//    NSString *index = [NSString stringWithFormat:@"%c", pinyinFirstLetter([weekly.name characterAtIndex:0])-32];
//    const char *str = [index UTF8String];
//    char ch = str[0];
//    NSString *indexStr;
//    if (isalpha(ch)) {
//        indexStr = [index uppercaseString];
//    }else
//    {
//        indexStr = @"~";
//    }
//    return indexStr;
//}



- (BOOL)deleteFromAddressBookWithRowid:(NSInteger)section Row:(NSInteger)row
{
    [self open];
    NSNumber *rowid = [self findRowIDUseSection:section Row:row];
    NSString *address = [NSString stringWithFormat:DELETETABLE];
    NSLog(@"%@",address);
    if ([self executeUpdate:address,rowid]) {
        [self indexOfAllDatabase];
        [self close];
        return YES;
    } else {
        [self close];
        return NO;
    }
    
    
}
- (BOOL)deleteFromAddressBookWithRowid:(NSInteger)rowid
{
    [self open];
    //    NSNumber *rowid = [self findRowIDUseSection:section Row:row];
    NSString *address = [NSString stringWithFormat:DELETETABLE];
    NSLog(@"%@",address);
    if ([self executeUpdate:address,rowid]) {
        [self indexOfAllDatabase];
        [self close];
        return YES;
    } else {
        [self close];
        return NO;
    }
    
    
}
- (NSNumber *)findRowIDUseSection:(NSInteger)section Row:(NSInteger)row
{
    NSString *indexStr = [_indexTitle objectAtIndex:section];
    NSDictionary *dict = [_indexDict objectForKey:indexStr];
    NSNumber *rowid = [dict objectForKey:[NSNumber numberWithInteger:row]];
    return rowid;
}





//根据indexPath获得数据
- (SWGWeekly *)returnItemWithSection:(NSInteger)section Row:(NSInteger)row
{
    [self open];
    NSString *str = [NSString stringWithFormat:SELECTROWID];
    NSNumber *rowid = [self findRowIDUseSection:section Row:row];
    FMResultSet *set = [self executeQuery:str,rowid];
    SWGWeekly *item = [self makeItemWithResultSet:set];
    [self close];
    return item;
}
//根据indexPath获得数据
- (SWGWeekly *)returnItemWithRowid:(NSInteger)rowid
{
    [self open];
    NSString *str = [NSString stringWithFormat:SELECTROWID];
    //NSNumber *rowid = [self findRowIDUseSection:section Row:row];
    FMResultSet *set = [self executeQuery:str,rowid];
    SWGWeekly *item = [self makeItemWithResultSet:set];
    [self close];
    return item;
}

//- (SWGWeekly *)makeItemWithResultSet:(FMResultSet *)set
//{
//    SWGWeekly *weekly = [[SWGWeekly alloc] init];
//    while ([set next]) {
//        weekly.name = [set stringForColumn:@"NAME"];
//        weekly.tel = [set stringForColumn:@"TEL"];
//        weekly.favorite = [set stringForColumn:@"FAVORITE"];
//    }
//    return weekly;
//}
/**
 *  将实体字段装箱
 */
//- (NSDictionary *)makeDictWithweekly:(SWGWeekly *)weekly
//{
//    NSString *index = weekly.index;
//    NSString *name = weekly.name;
//    NSString *tel = weekly.tel;
//    NSString *favorite = weekly.favorite;
//    NSDictionary *dict = @{@"index":index,
//                           @"name":name,
//                           @"tel":tel,
//                           @"favorite":favorite};
//    return dict;
//}


- (NSInteger)numberOfSections
{
    return 27;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSString *indexStr = [_indexTitle objectAtIndex:section];
    NSDictionary *dict = [_indexDict objectForKey:indexStr];
    return [dict count];
}
//返回搜索结果row数目
- (NSInteger)numberSearchItemOfIndex
{
    return [_seaechResult count];
}

//构建搜索结果索引
- (void)indexOfAllDatabaseForKeyWord:(NSString *)keyWord
{
    [self open];
    [_seaechResult removeAllObjects];
    NSString *temp = [NSString stringWithFormat:@"SELECT ROWID  FROM ADDRESS WHERE "
                      @"NAME LIKE '%%%@%%' OR "
                      @"TEL LIKE '%%%@%%' "
                      @"ORDER BY NAME;",
                      keyWord,keyWord];
    FMResultSet *set = [self executeQuery:temp];
    while ([set next]) {
        NSNumber *rowid = [NSNumber numberWithInteger:[set intForColumn:@"ROWID"]];
        [_seaechResult addObject:rowid];
    };
    [self close];
}

//构建搜索结果索引
- (void)indexOfAllDatabaseForfavorite
{
    [self open];
    [_seaechResult removeAllObjects];
    NSString *temp = [NSString stringWithFormat:@"SELECT ROWID  FROM ADDRESS WHERE "
                      @"FAVORITE == '1'"
                      @"ORDER BY NAME;"
                      ];
    FMResultSet *set = [self executeQuery:temp];
    while ([set next]) {
        NSNumber *rowid = [NSNumber numberWithInteger:[set intForColumn:@"ROWID"]];
        [_seaechResult addObject:rowid];
    };
    
    [self close];
    NSLog(@"seaechResult:%@",_seaechResult);
}


@end
