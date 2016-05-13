//
//  DataManager.h
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <FMDB/FMDB.h>

@interface DataManager : FMDatabase
@property (nonatomic,strong) NSArray *indexTitle;
+ (instancetype)shareDataBase;//单例
@property (nonatomic,strong) NSMutableArray *seaechResult;
@property (nonatomic,strong) NSMutableArray *favoriteResult;
- (BOOL)insertIntoDBWithItem:(SWGWeekly *)weekly;

- (BOOL)updateItemWithWeekly:(SWGWeekly *)weekly;

- (SWGWeekly *)returnWeeklyById:(NSString *)weeklyid;


//- (BOOL)updateItemWithIndexPath:(SWGWeekly *)weekly;
//- (BOOL)updateItemWithPerson:(SWGWeekly *)weekly Rowid:(NSInteger)rowid;
//- (BOOL)updateItemWithPerson:(SWGWeekly *)weekly Section:(NSInteger)section Row:(NSInteger)row;
//- (BOOL)deleteFromAddressBookWithRowid:(NSInteger)rowid;
//- (BOOL)deleteFromAddressBookWithSection:(NSInteger)section Row:(NSInteger)row;
//+ (SWGWeekly *)makeItemWithResultSet:(FMResultSet *)set;
//- (SWGWeekly *)returnItemWithSection:(NSInteger)section Row:(NSInteger)row;
//- (SWGWeekly *)returnItemWithRowid:(NSInteger)rowid;
//- (NSInteger)numberSearchItemOfIndex;
//- (void)indexOfAllDatabase;
//- (NSInteger)numberOfSections;
//- (NSInteger)numberOfRowsInSection:(NSInteger)section;
//
//- (void)indexOfAllDatabaseForKeyWord:(NSString *)keyWord;
//- (void)indexOfAllDatabaseForfavorite;
//- (NSNumber *)findRowIDUseSection:(NSInteger)section Row:(NSInteger)row;
@end
