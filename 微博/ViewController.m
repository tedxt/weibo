//
//  ViewController.m
//  微博
//
//  Created by piglikeyoung on 15/3/3.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "ViewController.h"
#import "NJWeibo.h"
#import "JHWeiboCell.h"

@interface ViewController ()

@property (strong , nonatomic) NSArray *statuses;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 数据源
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"status";
    // 1.缓存中取
    JHWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        // 系统的cell创建出来默认就有3个子控件提供给我们使用
        cell = [[JHWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // 3.设置数据
    cell.weibo = self.statuses[indexPath.row];
    
    // 4.返回
    return cell;
    
}

#pragma mark - 懒加载
- (NSArray *)statuses
{
    if (_statuses == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            NJWeibo *weibo = [NJWeibo weiboWithDict:dict];
            [models addObject:weibo];
        }
        self.statuses = [models copy];
    }
    return _statuses;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
