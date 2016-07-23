//
//  ViewController.m
//  TestUIBezierPath
//
//  Created by 赵广亮 on 16/7/23.
//  Copyright © 2016年 zhaoguangliang. All rights reserved.
//

#import "ViewController.h"
#import "Test_UIBezierPathView.h"
#define kNumberOfTypes 8
#define cGetEnumStringArray (_arrayOfEnumString == nil?\
_arrayOfEnumString = @[@"三角形",@"矩形",@"实心圆",@"空心圆",@"圆角矩形",@"左右圆角矩形",@"二次贝塞尔曲线",@"三次贝塞尔曲线"]:_arrayOfEnumString)
#define cGetCurrentTypeString(number) [cGetEnumStringArray objectAtIndex:number]

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) NSArray *arrayfDrawValue;
@property (nonatomic,assign) NSInteger currentNumber;
@property (nonatomic,copy) Test_UIBezierPathView *testBezierPathView;
@property (nonatomic,strong) NSArray *arrayOfEnumString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    }

//初始化
-(void)setUp{
    //将展示view添加到视图上
    [self.view addSubview:self.testBezierPathView];
    
    //默认显示第一个绘制的图形
    _currentNumber = 0;
    self.titleLabel.text = cGetCurrentTypeString(_currentNumber);
    LLBezierPahtEnum type = [self.arrayfDrawValue[_currentNumber] integerValue];
    [self.testBezierPathView drawBezierPathWithType:type];
}

//左边按钮点击事件
- (IBAction)leftBtnClick:(id)sender {
    if (_currentNumber == 0) {
        return;
    }
    LLBezierPahtEnum type = [self.arrayfDrawValue[--_currentNumber] integerValue];
    [self.testBezierPathView drawBezierPathWithType:type];
    
    self.titleLabel.text = cGetCurrentTypeString(_currentNumber);
}

//右边按钮点击事件
- (IBAction)rightBtnClick:(id)sender {
    if (_currentNumber == kNumberOfTypes - 1) {
        return;
    }
    LLBezierPahtEnum type = [self.arrayfDrawValue[++_currentNumber] integerValue];
    [self.testBezierPathView drawBezierPathWithType:type];
    
    self.titleLabel.text = cGetCurrentTypeString(_currentNumber);
}

//懒加载存储变量的数组
-(NSArray *)arrayfDrawValue{
    if (!_arrayfDrawValue) {
        _arrayfDrawValue = @[@(kBezierDrawTriangle),@(kBezierDrawRect),@(kBezierDrawFillCircle),@(kBezierDrawEmptyCircle),@(kBezierDrawCornerRect),@(kBezierDrawCornerRectOfLeftAndRight),@(kBezierDrawSecondBezierPath),@(kBezierDrawThirdBezierPath)];
    }
    return _arrayfDrawValue;
}

//懒加载绘制bezierPath的view
-(Test_UIBezierPathView *)testBezierPathView{
    if (!_testBezierPathView) {
       _testBezierPathView = [[Test_UIBezierPathView alloc] initWithFrame:CGRectMake(0, 90 + 28,k_ScreenWidth , k_ScreenHeight - 90 - 28)];
       _testBezierPathView.backgroundColor = [UIColor cyanColor];
    }
    return _testBezierPathView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
