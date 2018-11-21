//
//  Person.m
//  KVCDemoProject
//
//  Created by aofeilin on 2018/11/20.
//  Copyright © 2018年 com.aofeilin.com. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person
//2.手动控制自动通知
+ (BOOL) automaticallyNotifiesObserversForKey: (NSString*)aKey{
    if ([aKey isEqualToString:@"name"]){
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:aKey];
}
- (NSString *)fullName{
    return [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
}
//3.那么当firstName和lastName改动的时候，该值必须被通知。这是一种依赖方法。==
//+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
//    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
//    if ([key isEqualToString:@"fullName"]) {
//        NSSet *effectiingKeys = [NSSet setWithObjects:@"lastName",@"firstName", nil];
//        keyPaths = [keyPaths setByAddingObjectsFromSet:effectiingKeys];
//    }
//    return keyPaths;
//}
//3.那么当firstName和lastName改动的时候，该值必须被通知。这是一种依赖方法。==
+ (NSSet<NSString *> *)keyPathsForValuesAffectingFullName
{
    return [NSSet setWithObjects:@"lastName",@"firstName", nil];
}

//5.实现原理----
/**
 KVO会重写keyPath对应属性的setter方法，没有被KVO的属性则不会重写其setter方法。在重写的setter方法中，修改值之前会调用willChangeValueForKey:方法，修改值之后会调用didChangeValueForKey:方法，这两个方法最终都会被调用到observeValueForKeyPath:ofObject:change:context:方法中
 
 
 */

- (NSString *)description{
    IMP nameIMP = class_getMethodImplementation(object_getClass(self), @selector(setName:));
    IMP ageIMP = class_getMethodImplementation(object_getClass(self), @selector(setAge:));
    NSLog(@"nameIMp : %p  setAge:%p:",nameIMP,ageIMP);
    
    Class objectMethodClass = [self class];//类对象
    Class objectiSAClass = object_getClass(self);//isa
    Class superClass = class_getSuperclass(objectiSAClass);//isa 父类
    NSLog(@"objectMethodClass : %@, ObjectRuntimeClass : %@, superClass : %@ \n", objectMethodClass, objectiSAClass, superClass);
    
    NSLog(@"object method list \n");
    
    //method list
    unsigned int count;
    Method * methodList = class_copyMethodList(objectiSAClass, &count);
    for (NSInteger i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString * methodName = NSStringFromSelector(method_getName(method));
        NSLog(@"method name  %@",methodName);
    }
    return @"";
    /*
     2018-11-20 17:59:22.015399+0800 KVCDemoProject[6423:680795] keyPath:age
     2018-11-20 17:59:22.015665+0800 KVCDemoProject[6423:680795] nameIMp : 0x1016151a0  setAge:0x10196e63a:
     2018-11-20 17:59:22.015835+0800 KVCDemoProject[6423:680795] objectMethodClass : Person, ObjectRuntimeClass : NSKVONotifying_Person, superClass : Person
     2018-11-20 17:59:22.016033+0800 KVCDemoProject[6423:680795] object method list
     2018-11-20 17:59:22.016164+0800 KVCDemoProject[6423:680795] method name  setAge:
     2018-11-20 17:59:22.016498+0800 KVCDemoProject[6423:680795] method name  class
     2018-11-20 17:59:22.016699+0800 KVCDemoProject[6423:680795] method name  dealloc
     2018-11-20 17:59:22.017001+0800 KVCDemoProject[6423:680795] method name  _isKVOA
     2018-11-20 17:59:22.018619+0800 KVCDemoProject[6423:680795] object:
     2018-11-20 17:59:22.019365+0800 KVCDemoProject[6423:680795] change:{
     kind = 1;
     new = 18;
     }
     
     */
    
    
    
}
@end
