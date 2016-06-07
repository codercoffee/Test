//
//  AppDelegate.h
//  Test
//
//  Created by wk on 16/3/25.
//  Copyright © 2016年 wk. All rights reserved.
//

/*
 代码要求
 
 ================ 注释规则 ================
 .h/m需要有模块注释，头文件和源文件各一份
 
 @class、@protocal头部需要有功能描述
 
 普通方法和类方法成员头部需要有功能描述、返回值描述、参数说明，显而易见的方法除外，如：init、dealloc、viewDidLoad等
 
 重要代码块需要有概括性描述，建议使用 // --vv--、// ====vvvv==== 等概括性备注
 
 
 ================ 命名规则 ================
 xib模块名要与.h/m命名一致
 
 类名/文件名需要增加前缀和后缀，如：XMxxxxxViewController、XMxxxxxView，通用模块和控件可以不增加前缀，如UIColorfulButton
 
 方法名采用这种格式：- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section，注意空格符的位置，只在“-”后面及参数分隔有空格，其余地方均不能出现多余空格，指针类型可以考虑在括号内插入空格
 
 普通变量、成员变量需要采用标准的驼峰命名规则，如：usrIDListArr、loginButton、inputTextView、outputTableView等
 
 一些控件事件的命名，需要采用控件名+事件的命名规则，如：loginButtonTouchUp等
 
 
 ================ 语法规则 ================
 方法的左大括号换行对齐，if、for、while等结构性语句可选，但嵌套使用时，风格要保持统一
 
 代码段落上不要有多余的空行，也不能该空行的地方不空行。如方法之间空一行，方法内重要代码块之间空一行 等。
 
 
 ================ 代码优化 ================
 不需要对外的部分，一律不要在.h头文件中暴露，包括#import、@protocal、@property以及方法等，做到严密封装，高内聚低耦合
 
 不要使用@synthesize，也不要在{}里增加成员，统一使用@property定义成员变量，@property区域前半段定义IBOutlet后半段定义普通成员，顺序整理清晰易维护
 
 在使用成员变量时，只有两种情况需要使用带下划线的成员表达方式，一种是在模块第一次初始化，如：_loginButton = [[UIButton alloc] init]，另一种情况是在模块析构方法dealloc里，如：[_loginButton release]，其余情况均需采用self.前缀，如：self.loginButton
 
 避免在代码中直接使用常量，可适当在模块顶部使用宏定义，对于比较通用的常量，可以把宏放入预编译文件中定义
 
 init、initWithxxxx、dealloc、viewDidLoad这些通用方法，尽量放到模块前面，其他自定义方法往后放
 
 dealloc方法放在方法定义首位
 
 未删除明显的冗余代码

*/

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

