//
//  ViewController.m
//  kvoDemoProject
//
//  Created by aofeilin on 2018/11/16.
//  Copyright © 2018年 com.sphere.opg.sbuy. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
@interface ViewController (){
   People *variable;
    NSString *_name;
    NSString *_isName;
    NSString *name;
    NSString *isName;
}
@property (nonatomic,strong)NSNumber *number;
@property (nonatomic,assign)int numInt;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)NSMutableArray *muArray;
@property (nonatomic,strong)NSDictionary *dics;
@property (nonatomic,strong)NSMutableDictionary *muDics;
@property (nonatomic,strong)NSMutableArray *array8;
@property (nonatomic,strong)NSString *pName;
@property (nonatomic,strong)NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //0.搜索流程
    // 0.1 setter方法
    // 0.2(如果没有找到setName：方法，KVC机制会检查+ (BOOL)accessInstanceVariablesDirectly方法有没有返回YES，默认该方法会返回YES，如果你重写了该方法让其返回NO的话，那么在这一步KVC会执行setValue：forUndefinedKey：
        //成员变量，_<key>成员变量
    //0.3 如果没有成员变量，_is<Key>
    //0.4 如果没有 _<key> _is<key>  继续搜索 <key> is<key>
    //0.5 如果上面列出的方法或者成员变量都不存在，系统将会执行该对象的setValue：forUndefinedKey：方法，默认是抛出异常。
    /*
     self.name
     _name
     _isName
     name
     isName
    */
    //0.1
//    [self setValue:@"王五" forKey:@"pName"];
//    NSLog(@"self.name = %@", self.pName);
    
    [self setValue:@"王五" forKey:@"name"];
    NSLog(@"name = %@", self.name);
    
    //0.2
    [self setValue:@"王五" forKey:@"name"];
    NSLog(@"name = %@", _name);
    //0.3
    
    [self setValue:@"王五" forKey:@"name"];
    NSLog(@"name = %@", _isName);
    
    //0.4
    [self setValue:@"王五" forKey:@"name"];
     NSLog(@"name = %@", name);
    //0.5
    [self setValue:@"王五" forKey:@"name"];
    NSLog(@"name = %@", isName);
    
    //1.属性的赋值
    [self setValue:@(100) forKey:@"number"];
    NSLog(@"%@",[self valueForKey:@"number"]);
    NSLog(@"%ld",self.number.integerValue);
    
    //2.变量的赋值
    People *p  = [[People alloc] init];
    [self setValue:p forKey:@"variable"];
    
    //3.对象属性的赋值
    [self setValue:@"lucy" forKeyPath:@"variable.name"];
    NSLog(@"%@",[self valueForKeyPath:@"variable.name"]);
    NSLog(@"%@",variable.name);
    
    //4.NSArray、、NSDictionary、 2.NSMutableArray。NSMutableDictionary等有序容器和 3.NSSet等无序容器。
    NSDictionary *dic = @{@"name":@"zhangsan",@"age":@"10",@"class":@"1"};
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self setValue:mDic forKey:@"muDics"];
    NSLog(@"%@",[self valueForKey:@"muDics"]);
    
    [self setValue:dic forKey:@"dics"];
    NSLog(@"%@",[self valueForKey:@"dics"]);
    
    [self setValue:@[@"name",@"zhangsan",@"age",@"10"] forKey:@"array"];
    NSLog(@"%@",[self valueForKey:@"array"]);
    NSMutableArray *arrays = [NSMutableArray arrayWithArray:self.array];
    [self setValue:arrays forKey:@"muArray"];
    [[self valueForKey:@"muArray"] addObject:@"Two"];
    [[self valueForKey:@"muArray"] addObject:@"Three"];
    NSLog(@"%@",[self valueForKey:@"muArray"]);
   
    //5.1NSUndefinedKeyException异常 setValue:forUndefinedKey:
    //5.2setValuesForKeysWithDictionary
    [variable setValuesForKeysWithDictionary:self.muDics];
    NSLog(@"%@ ---- %@-----%@",variable.name,variable.age,variable.mId);
    //5.3dictionaryWithValuesForKeys
    NSArray *keys = @[@"name",@"class"];
    NSDictionary *values = [self.muDics dictionaryWithValuesForKeys:keys];
    NSLog(@"%@",values);
    
    //6.异常处理 -重写方法，-(void)setValue:(id)value forUndefinedKey:(NSString *)key
    NSLog(@"%@ ---- %@-----%@",variable.name,variable.age,variable.mId);
    //6.1 nil 如果是int类型的不能赋值给nil 其他类型可以设置nil 如果是int -(void)setNilValueForKey:(NSString *)key 设置这个不会崩哭
    [self setValue:nil forKey:@"number"];
    [self setValue:nil forKey:@"numInt"];
    
    
    //7.keyPath操作符号
       //left key path.  collectionoOperator  .right key path.
    //7.1 集合运算符 返回值以NSNumber为主。
        //@avg.amount  @count @sum.amount @max.date  @min.date
    
    NSNumber *number1 = [self.array valueForKeyPath:@"@count"];
    NSLog(@"%ld",(long)number1.integerValue);
    
    //7.2 数组操作符 将复合条件的对象放在数组中。返回。
    //7.3 嵌套操作符 处理集合对象中嵌套其他集合对象的情况，返回结果也是一个集合对象。
    People *p8  = [[People alloc] init];
    p8.name = @"zhangsan";
    p8.age = @"19";
    People *p9  = [[People alloc] init];
    p9.name = @"lisi";
    p9.age = @"19";
    self.array8 = [NSMutableArray array];
    [self.array8 addObject:p8];
    [self.array8 addObject:p9];
    
    People *p11 = [[People alloc] init];
    p11.name = @"lisi11";
    p11.age = @"19";
    p11.price = 100;
    People *p12 = [[People alloc] init];
    p12.name = @"lisi12";
    p12.age = @"19";
    p12.price = 100;
    NSMutableArray *array11 = [NSMutableArray array];
    [array11 addObject:p12];
    [array11 addObject:p11];
    NSArray * array9 = [self.array8 valueForKeyPath:@"@unionOfObjects.name"];
    NSLog(@"%@",array9);
    NSLog(@"%@",self.array8);
    
    NSArray * array10 = [self.array8 valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"%@",array10);
     NSLog(@"%@",self.array8);
    
    NSArray *array15 = @[self.array8, array11];
    NSArray *collectedPayees = [array15 valueForKeyPath:@"@unionOfArrays.name"];
    NSLog(@"%@",collectedPayees);
    
    NSArray *array = @[@(p11.price), @(p12.price)];
    NSNumber *avg = [array valueForKeyPath:@"@avg.self"];
    NSLog(@"%ld",avg.integerValue);
    
    NSArray *arr = @[@"john", @"tom", @"lucy", @"lily"];
    NSArray *captainArr = [arr valueForKey:@"capitalizedString"];
    NSLog(@"captainArr = %@", captainArr);
    
    NSArray *lengthArr = [arr valueForKeyPath:@"capitalizedString.length"];
    NSLog(@"lengthArr = %@",lengthArr);
    /*
     @distinctUnionOfArrays
     @unionOfArrays
     @distinctUnionOfSets
     */
    
    //8.1属性value验证
//    People *p12 = [[People alloc] init];
//    p12.name = @"lisi12";
//    p12.age = @"19";
//    p12.price = 100;
    NSString * name = @"lisi12";
    NSError *error;
    if (![p12 validateValue:&name forKey:@"name"  error:&error]){
        NSLog(@"%@",error);
    }
    else{
         NSLog(@"验证正确");
    }
}

 //6.1 nil 如果是int类型的不能赋值给nil 如果是int
-(void)setNilValueForKey:(NSString *)key{
    
}


@end
