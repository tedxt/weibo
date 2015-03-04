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
#import "JHWeiboFrame.h"

@interface ViewController ()

@property (strong , nonatomic) NSArray *statusFrames;


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
    return self.statusFrames.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHWeiboCell *cell = [JHWeiboCell cellWithTableView:tableView];
    
    // 3.设置数据
    cell.weiboFrame = self.statusFrames[indexPath.row];
    
    // 4.返回
    return cell;
    
}

#pragma mark - 懒加载
- (NSArray *)statusFrames
{
    if (_statusFrames == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            // 创建模型
            NJWeibo *weibo = [NJWeibo weiboWithDict:dict];
            // 根据模型数据创建frame模型
            JHWeiboFrame *wbF = [[JHWeiboFrame alloc] init];
            wbF.weibo = weibo;
            [models addObject:wbF];
        }
        self.statusFrames = [models copy];
    }
    return _statusFrames;
}

#pragma mark - 代理方法
// 这个方法比cellForRowAtIndexPath先调用，即创建cell的时候得先知道它的高度，所以高度必须先计算
// 所以在懒加载的时候获取微博的数据立即去计算行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出相应行的frame模型
    JHWeiboFrame *wbf = self.statusFrames[indexPath.row];
    NSLog(@"hright = %f",wbf.cellHeight);
    return wbf.cellHeight;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
