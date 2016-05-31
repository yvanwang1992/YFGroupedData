//
//  ViewController.m
//  YFMetroListBox
//
//  Created by admin on 16/5/23.
//  Copyright © 2016年 Yvan Wang. All rights reserved.
//

#import "MainViewController.h"
#import "YFMetroListBox.h"
#import "YFGroupedData.h"

#define kIndexKey @"title"
#define kArrayKey @"array"

#define kCell @"cell"
#define kHeaderView @"headerView"


@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, YFMetroListBoxDelegate>

@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) YFMetroListBox *metroListBox;

@end


@implementation MainViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)removeSection{
    if(self.arrayData.count == 0){
        return;
    }
    [self.arrayData removeObjectAtIndex:0];
    [self.metroListBox deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.view setBackgroundColor:[UIColor grayColor]];

    self.title = @"YFMetroListBox";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除第一组" style:UIBarButtonItemStylePlain target:self action:@selector(removeSection)];
    
    NSArray *array = [YFGroupedData getGroupedDictionaryArray:@[@"Once",@"Begin Again",@"hello wolrd",@"~",@"Windows",@"Lumia",@"苏菲",@"Yvan Wang",@"超能陆战队",@"Angry birds",@")",@"%",@"Windows Phone",@"950XL",@"速度与激情",@"1520",@"Titanic",@"霸王别姬",@"Captain America",@"World of Warcraft",@"星际穿越",@"反叛的鲁鲁修",@"消失的爱人",@"The Love of Siam",@"荷尔蒙",@"爱·回家",@"7号房的礼物",@"春夏秋冬又一春",@"The Little Prince",@"太阳的后裔",@"非首脑会谈",@"初恋这件小事",@"",@"Baby And Me",@"疯狂动物城",@"Old Boy",@"我的女孩",@"奔跑吧兄弟",@"我滴个神啊"]indexKey:kIndexKey arrayKey:kArrayKey];
    self.arrayData = [NSMutableArray arrayWithArray:array];
    
    self.metroListBox = [[YFMetroListBox alloc] initWithFrame:self.view.bounds];
    self.metroListBox.backgroundColor = [UIColor whiteColor];
    self.metroListBox.metroListBoxType = YFMetroListBoxTypeAllAlphabet;
    self.metroListBox.sectionHeaderHeight = 40;

    self.metroListBox.itemSize = CGSizeMake(50, 50);
    self.metroListBox.interSize = CGSizeMake(10, 10);
//    self.metroListBox.itemBackgroundColor = [UIColor redColor];
    
    self.metroListBox.listBoxDelegate = self;
    self.metroListBox.delegate = self;
    self.metroListBox.dataSource = self;
    
    [self.metroListBox registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];
    [self.metroListBox registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderView];
    
    [self.view addSubview:self.metroListBox];
    
}

#pragma mark -m UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrayData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = [self.arrayData objectAtIndex:section];
    NSArray *array = [dic objectForKey:kArrayKey];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    
    NSDictionary *dic = [self.arrayData objectAtIndex:indexPath.section];
    NSArray *array = [dic objectForKey:kArrayKey];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}


#pragma mark -m YFMetroListBoxDelegate
- (NSArray<NSString *> *)sectionIndexTitlesForYFMetroListBox:(YFMetroListBox *)metroListBox{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; i < self.arrayData.count; i++) {
        NSDictionary  *dic = [self.arrayData objectAtIndex:i];
        [array addObject:[dic objectForKey:kIndexKey]];
    }
    return array;
}

#pragma mark -m UITableViewDelegate

//Default
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSDictionary  *dic = [self.arrayData objectAtIndex:section];
//    return [dic objectForKey:@"title"];
//}

//有了下面这个  上面这个就无效了
//使用自定义的
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderView];
    [header.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,40)];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor lightGrayColor];
    [header addSubview:label];
    
    NSDictionary *dic = [self.arrayData objectAtIndex:section];
    NSString *title = [dic objectForKey:kIndexKey];
    label.text = title;
    return header;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
