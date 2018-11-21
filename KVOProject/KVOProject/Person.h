//
//  Person.h
//  KVCDemoProject
//
//  Created by aofeilin on 2018/11/20.
//  Copyright © 2018年 com.aofeilin.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic,strong)NSString *age;
@property (nonatomic,strong)NSString *name;
//3.依赖
@property (nonatomic,copy)NSString *fullName;
@property (nonatomic,copy)NSString *firstName;
@property (nonatomic,copy)NSString *lastName;
//4.测试KVO
@property (nonatomic,copy)NSString *content;
@end

NS_ASSUME_NONNULL_END
