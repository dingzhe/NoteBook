//
//  NSObject+Ext.m
//  bolome_shared
//
//  Created by by on 3/13/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import "NSObject+Ext.h"
#import <objc/runtime.h>

@implementation NSObject(Ext_private)

- (NSString *)_valueForProperty:(objc_property_t *)p{
    NSString *result = nil;
    
    NSString *name = [NSString stringWithUTF8String:property_getName(*p)];
    const char *attributes = property_getAttributes(*p);
    
    id value = nil;
    switch (attributes[1]) {
            
            // Object
        case '@':
            if (!(value = [self valueForKey:name]))
                result = @"(null)";
            else if(value == self)
                result = @"(self)";
            else
                result = [value propertiesDescription];
            
            break;
            
            // Pointer, do nothing
        case '^':
            result = @"POINTER VALUE";
            break;
            
        default:
            result = [NSString stringWithFormat:@"%@", [self valueForKey:name]];
            break;
    }
    
    return result;
}

- (NSString *)_propertiesNameAndValueForClass:(Class)cls{
    NSString *result = nil;
    
    unsigned int size = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &size);
    
    NSMutableString *content = [NSMutableString stringWithCapacity:128];
    NSString *superContent = nil;
    
    Class superCls = class_getSuperclass(cls);
    if (superCls &&
        superCls != [NSObject self] &&
        superCls != [NSProxy self]){
        superContent = [self _propertiesNameAndValueForClass:superCls];
    }
    
    for (NSUInteger index = 0; index < size; ++index) {
        NSString *name = [NSString stringWithUTF8String:property_getName(properties[index])];
        NSString *value = [self _valueForProperty:properties + index];
        
        NSString *pair = [NSString stringWithFormat:@"\"%@\":%@", name, value];
        
        [content insertString:pair atIndex:0];
        if (index != (size - 1))
            [content insertString:@", " atIndex:0];
    }
    
    free(properties);
    properties = NULL;
    
    if ([superContent length]){
        [content insertString:@", " atIndex:0];
        [content insertString:superContent atIndex:0];
    }
    
    if ([content length])
        result = [NSString stringWithString:content];
    
    return result;
}

- (BOOL )_property:(objc_property_t *)p isEqualToObject:(NSObject *)obj{
    BOOL result = NO;
    
    NSString *name = [NSString stringWithUTF8String:property_getName(*p)];
    const char *attributes = property_getAttributes(*p);
    
    switch (attributes[1]) {
            
            // Object
        case '@':
            result = [[self valueForKey:name] isPropertiesEqual:[obj valueForKey:name]];
            break;
            
        default:
            result = [[self valueForKey:name] isEqual:[obj valueForKey:name]];
            break;
    }
    
    return result;
}

- (BOOL)_class:(Class)cls isPropertiesEqualToObject:(NSObject *)obj{
    BOOL result = NO;
    
    Class superCls = class_getSuperclass(cls);
    if (superCls &&
        superCls != [NSObject self] &&
        superCls != [NSProxy self]){
        result = [self _class:superCls isPropertiesEqualToObject:obj];
    }
    
    if (result) {
        unsigned int size = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &size);
        for (NSUInteger index = 0; index < size; ++index){
            result = result && [self _property:properties+index isEqualToObject:obj];
            
            if (!result)
                break;
        }
    }
    
    return result;
}

@end

@implementation NSObject(Ext)

- (NSString *)propertiesDescription{
    NSString *result = nil;
    
    // Basic Data types
    if ([self isKindOfClass:[NSString self]] ||
        [self isKindOfClass:[NSDate self]] ||
        [self isKindOfClass:[NSNumber self]] ||
        [self isKindOfClass:[NSData self]] ||
        [self isKindOfClass:[NSNull self]]) {
        result = [NSString stringWithFormat:@"\"%@\"", [self description]];
    }
    
    // Containers
    else if([self isKindOfClass:[NSArray self]] ||
            [self isKindOfClass:[NSSet self]] ||
            [self isKindOfClass:[NSDictionary self]]){
        
        if([self isKindOfClass:[NSArray self]] ||
           [self isKindOfClass:[NSSet self]]){
            NSMutableString *tmpResult = [NSMutableString stringWithCapacity:128];
            
            [tmpResult appendString:@"["];
            
            NSArray *array = (NSArray *)self;
            if ([self isKindOfClass:[NSSet self]])
                array = [(NSSet *)self allObjects];
            
            for (NSUInteger index = 0; index < [array count]; ++index) {
                NSString *des = [[array objectAtIndex:index] propertiesDescription];
                [tmpResult appendString:des];
                
                if (index != ([array count] - 1))
                    [tmpResult appendString:@", "];
            }
            
            [tmpResult appendString:@"]"];
            
            result = [NSString stringWithString:tmpResult];
        }
        else if([self isKindOfClass:[NSDictionary self]]){
            NSMutableString *tmpResult = [NSMutableString stringWithCapacity:128];
            
            [tmpResult appendString:@"{"];
            
            NSDictionary *dict = (NSDictionary *)self;
            NSArray *keys = [dict allKeys];
            for (NSUInteger index = 0; index < [keys count]; ++index) {
                NSString *key = [keys objectAtIndex:index];
                NSString *pair = [NSString stringWithFormat:@"\"%@\":%@",
                                  key, [[dict objectForKey:key] propertiesDescription]];
                [tmpResult appendString:pair];
                
                if (index != ([keys count] - 1))
                    [tmpResult appendString:@", "];
            }
            
            [tmpResult appendString:@"}"];
            
            result = [NSString stringWithString:tmpResult];
        }
        
    }
    
    // Other objects
    else{
        result = [self _propertiesNameAndValueForClass:[self class]];
        if ([result length])
            result = [NSString stringWithFormat:@"{%@}", result];
    }
    
    return result;
}

- (BOOL)isPropertiesEqual:(NSObject *)obj{
    if (![obj isMemberOfClass:[self class]])
        [NSException raise:NSInvalidArgumentException
                    format:@"%@", @"\"isPropertiesEqual\" compared objects must be the same class."];
    
    BOOL result = NO;
    
    result = [[self propertiesDescription] isEqualToString:[obj propertiesDescription]];
    
    return result;
}

- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo setArgument:&p4 atIndex:5];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo setArgument:&p4 atIndex:5];
        [invo setArgument:&p5 atIndex:6];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 withObject:(id)p6 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo setArgument:&p4 atIndex:5];
        [invo setArgument:&p5 atIndex:6];
        [invo setArgument:&p6 atIndex:7];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 withObject:(id)p6 withObject:(id)p7 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo setArgument:&p4 atIndex:5];
        [invo setArgument:&p5 atIndex:6];
        [invo setArgument:&p6 atIndex:7];
        [invo setArgument:&p7 atIndex:8];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

- (void) methodSwizzleSelector:(SEL)selector withSelector:(SEL)overrideSEL {
}

+ (void) methodSwizzleSelector:(SEL)selector withSelector:(SEL)overrideSelector {
    Method origMethod = class_getInstanceMethod(self, selector);
    Method overrideMethod = class_getInstanceMethod(self, overrideSelector);
    if(class_addMethod(self, selector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(self, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

- (void) notifyValueChangeForKey:(NSString *) key {
    [self willChangeValueForKey:key];
    [self didChangeValueForKey:key];
}

@end
