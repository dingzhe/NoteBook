//
//  CommonTextCellModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MessageType.h"

typedef NS_ENUM(NSUInteger, CommonTextCellEditType) {
    CommonTextCellEditTypeNormal = 0,
    CommonTextCellEditTypeDisable,
    CommonTextCellEditTypeInputField,
    CommonTextCellEditTypeTextView,
    CommonTextCellEditTypeDatePickerView,
    CommonTextCellEditTypeCustomPickerView,
    CommonTextCellEditTypeDictSelect,
    CommonTextCellEditTypeImageUpload,
    CommonTextCellEditTypeSwitch,
};

@interface CommonTextCellModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) NSString *detailText;
@property (nonatomic,strong) NSString *tag;
@property (nonatomic,assign) BOOL showIndicator;
@property (nonatomic,assign) BOOL showSwitch;
@property (nonatomic,assign) BOOL isBlog;
@property (nonatomic,strong) NSString *destinationVC;
@property (nonatomic,strong) NSString *dictType;
@property (nonatomic,strong) NSString *dictPcode;
@property (nonatomic,strong) NSArray *pickerAry;
@property (nonatomic,strong) NSString *imageType;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *count;
//@property (nonatomic,strong) SWGVisionDict *dict;
@property (nonatomic,assign) CommonTextCellEditType editType;
//@property (nonatomic,assign) MessageType messageType;

//- (instancetype)initWithDict:(SWGVisionDict*)dict;
- (instancetype)initWithDictType:(NSString*)type pcode:(NSString*)pcode;
- (instancetype)initWithImageType:(NSString*)imageType imageUrl:(NSString*)imageUrl;
- (instancetype)initShowSwitch;


@end
