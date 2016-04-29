//
//  NSObject+Ext.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

#define GET_ASSOCIATED_OBJ() objc_getAssociatedObject(self, _cmd)

#define _SET_ASSOCIATED_OBJ_OPT(obj, opt)           objc_setAssociatedObject(self, @selector(obj), (obj), (opt))
#define SET_ASSOCIATED_OBJ_ASSIGN(obj)              _SET_ASSOCIATED_OBJ_OPT(obj, OBJC_ASSOCIATION_ASSIGN)
#define SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(obj)    _SET_ASSOCIATED_OBJ_OPT(obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
#define SET_ASSOCIATED_OBJ_COPY_NONATOMIC(obj)      _SET_ASSOCIATED_OBJ_OPT(obj, OBJC_ASSOCIATION_COPY_NONATOMIC)
#define SET_ASSOCIATED_OBJ_RETAIN(obj)              _SET_ASSOCIATED_OBJ_OPT(obj, OBJC_ASSOCIATION_RETAIN)
#define SET_ASSOCIATED_OBJ_COPY(obj)                _SET_ASSOCIATED_OBJ_OPT(obj, OBJC_ASSOCIATION_COPY)

#pragma mark -

#define IMP_GETTER(varL, varl, var, type) \
- (type) varl##var { \
return _##varl##var; \
}

#define IMP_GETTER_BOOL(varL, varl, var) \
- (BOOL) is##varL##var { \
return _##varl##var; \
}

#define IMP_SETTER(varL, varl, var, type) \
- (void) set##varL##var: (type) varl##var { \
_##varl##var = varl##var; \
}

#pragma mark -

#define DEF_SINGLETON(methodName) \
+ (instancetype)methodName;

#define DEF_SINGLETON_W_CLASS(methodName, class) \
+ (class *)methodName;

#define BEGIN_IMP_SINGLETON(methodName, class) \
+ (class *)methodName { \
static class *instance = nil; \
static dispatch_once_t once; \
dispatch_once(&once, ^{ \

#define END_IMP_SINGLETON \
}); \
return instance; \
}

#define IMP_SINGLETON(methodName, class) \
BEGIN_IMP_SINGLETON(methodName, class) \
instance = [[self alloc] init]; \
END_IMP_SINGLETON

@interface NSObject(Ext)

/*
 * Return object properties' name and value in JSON format
 */
- (NSString *)propertiesDescription;
- (BOOL)isPropertiesEqual:(NSObject *)obj;

/**
 * Copy from Three20
 * Additional performSelector signatures that support up to 7 arguments.
 */
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3;
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4;
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5;
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 withObject:(id)p6;
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 withObject:(id)p6 withObject:(id)p7;

+ (void) methodSwizzleSelector:(SEL)selector withSelector:(SEL)overrideSEL;

- (void) notifyValueChangeForKey:(NSString *) key;

@end
