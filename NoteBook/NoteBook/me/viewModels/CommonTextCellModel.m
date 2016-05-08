//
//  CommonTextCellModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CommonTextCellModel.h"

@implementation CommonTextCellModel

- (id) init {
    self = [super init];
    if (self) {
        self.title = @"";
        self.subTitle = @"";
        self.detailText = @"";
        self.showIndicator = YES;
        self.editType = CommonTextCellEditTypeNormal;
    }
    return self;
}

//- (instancetype)initWithDict:(SWGVisionDict*)dict {
//    self = [super init];
//    if (self) {
//        self.dict = dict;
//        self.title = dict.name;
//        self.subTitle = @"";
//        self.detailText = @"";
//        if ([dict.last integerValue] == 0) {
//            self.showIndicator = YES;
//        }else{
//            self.showIndicator = NO;
//        }
//    }
//    return self;
//}

- (instancetype)initWithDictType:(NSString*)type pcode:(NSString*)pcode {
    self = [super init];
    if (self) {
        self.editType = CommonTextCellEditTypeDictSelect;
        self.dictType = type;
        self.dictPcode = pcode;
        self.showIndicator = YES;
    }
    return self;
}

- (instancetype)initWithImageType:(NSString*)imageType imageUrl:(NSString*)imageUrl {
    self = [super init];
    if (self) {
        self.editType = CommonTextCellEditTypeImageUpload;
        self.imageUrl = imageUrl;
        self.imageType = imageType;
        self.showIndicator = YES;
    }
    return self;
}


@end
