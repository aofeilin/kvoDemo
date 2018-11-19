//
//  People.m
//  kvoDemoProject
//
//  Created by aofeilin on 2018/11/16.
//  Copyright © 2018年 com.sphere.opg.sbuy. All rights reserved.
//

#import "People.h"

@implementation People
//如果有没有key 会调用这个方法。
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"class"]) {
        self.mId = key;
    }
}
//8.2 属性方法验证
-(BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError{
        NSString * name =  *ioValue;
        if ([name isEqualToString:@"lisi12"]) {
            return YES;
        }
        return NO;
}
@end
