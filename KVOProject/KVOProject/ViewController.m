//
//  ViewController.m
//  KVCDemoProject
//
//  Created by aofeilin on 2018/11/20.
//  Copyright © 2018年 com.aofeilin.com. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+KVO.h"
@interface ViewController ()
@property (nonatomic,strong)Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.注册观察者
    self.person = [[Person alloc]init];
    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    //1.1 NSKeyValueObservingOptionNew
    /*
     2018-11-20 16:21:40.847239+0800 KVCDemoProject[2899:497961] change:{
     kind = 1;
     new = 18;
     
     }
     */
    //1.2 NSKeyValueObservingOptionInitial
    //1.3 NSKeyValueObservingOptionOld
    /*
     2018-11-20 16:27:09.705258+0800 KVCDemoProject[3011:509590] change:{
     kind = 1;
     old = "<null>";
     }
     */
    //1.4 NSKeyValueObservingOptionPrior
    /*
     2018-11-20 16:28:04.816669+0800 KVCDemoProject[3057:512098] change:{
     kind = 1;
     notificationIsPrior = 1;
     }
     2018-11-20 16:28:04.816781+0800 KVCDemoProject[3057:512098] context:(null)
     2018-11-20 16:28:04.816919+0800 KVCDemoProject[3057:512098] keyPath:age
     2018-11-20 16:28:04.817045+0800 KVCDemoProject[3057:512098] object:<Person: 0x600001bc06a0>
     2018-11-20 16:28:04.817240+0800 KVCDemoProject[3057:512098] change:{
     kind = 1;
     }
     */
    
    self.person.age = @"18";
    //2.手动控制自动通知
    self.person.name = @"aofeilin";
    //4.依赖属性
    [self.person addObserver:self forKeyPath:@"fullName" options:NSKeyValueObservingOptionNew context:nil];
    self.person.firstName = @"WANG";
    self.person.lastName = @"Gang";
    self.person.firstName = @"LI";
    self.person.lastName = @"QIANG";
    //5.实现原理----
    //5.1.缺点：1.重复add remove 导致crash,observer释放导致的崩溃，keyPath 传错导致的崩溃，在调用KVO时需要传入一个keyPath
    //5.2.NSStringFromSelector(@selector(isFinished))
    //5.3.不支持block语法，
    //5.4.自己实现。
    
    [self.person PG_addObserver:self forKey:NSStringFromSelector(@selector(content))
                      withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                          NSLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
                          dispatch_async(dispatch_get_main_queue(), ^{
                              self.textField.text = newValue;
                          });
                      }];
    
    
    [self buttonAction:nil];
    
    
    
}
//3.手动通知的触发 如果 automaticallyNotifiesObserversForKey name属性 return NO.
- (IBAction)buttonAction:(id)sender {
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.person.content = msgs[index];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"keyPath:%@",keyPath);
    NSLog(@"object:%@",object);
    NSLog(@"change:%@",change);
    NSLog(@"context:%@",context);
}

-(void)dealloc{
    //remove 注册
}

@end
