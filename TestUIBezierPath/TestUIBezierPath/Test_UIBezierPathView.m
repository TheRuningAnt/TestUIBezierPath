//
//  Test_UIBezierPathView.m
//  TestUIBezierPath
//
//  Created by 赵广亮 on 16/7/23.
//  Copyright © 2016年 zhaoguangliang. All rights reserved.
//

#import "Test_UIBezierPathView.h"
@interface Test_UIBezierPathView()
{
    LLBezierPahtEnum drawType;
}
@end


@implementation Test_UIBezierPathView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    switch (drawType) {
        case kBezierDrawTriangle:
            [self drawtriangle];
            break;
        case kBezierDrawRect:
            [self drawRectangle];
            break;
        case kBezierDrawFillCircle:
            [self drawFillCircle];
            break;
        case kBezierDrawEmptyCircle:
            [self drawEmptyCircle];
            break;
        case kBezierDrawCornerRect:
            [self drawCornerRectangle];
            break;
        case kBezierDrawCornerRectOfLeftAndRight:
            [self drawRectWithLeftAndRightCorner];
            break;
        case kBezierDrawSecondBezierPath:
            [self drawSecondBezierPath];
            break;
        case kBezierDrawThirdBezierPath:
            [self drawThirdBezierPath];
            break;
        default:NSLog(@"%s--未匹配枚举值",__FUNCTION__);
            break;
    }

}

-(void)drawBezierPathWithType:(LLBezierPahtEnum)type{
    drawType = type;
    
    //使用该方法调用drawRect函数
    [self setNeedsDisplay];
    }

//绘制一个三角形  该方法会详细讲述各个参数的意思及使用方法,后面的方法仅仅展示使用方法
-(void)drawtriangle{
    //绘制一条完整路径  首先创建路径对象,接着按绘制顺序添加关键点,最后调用[path closePath]方法闭合路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(40, self.frame.size.height - 40)];
    [path addLineToPoint:CGPointMake(k_ScreenWidth - 40, self.frame.size.height - 40)];
    [path addLineToPoint:CGPointMake(k_ScreenWidth/2, 40)];
    [path closePath];
    
    /*设置填充颜色   创建一个颜色对象之后,需要调用颜色的set方法设置上下文环境,接着调用路径的fill方法使用上下文环境中的颜色来填充
    Tip: 这个fill方法很有意思
         如果第一次设置上下文环境为红色,那么调用fill的则会为该路径内填充红色
         但是第二次设置上下文环境为绿色时,调用fill方法并不是说将路径内的红色替换掉,而是在红色的上方填充一次绿色
         我会在博客里验证,读者也可自行验证
    */
    UIColor *redColor = [UIColor redColor];
    [redColor set];
    [path fill];
    
    //设置线条属性
    path.lineCapStyle = kCGLineJoinRound;  //线段端点格式
    path.lineJoinStyle = kCGLineJoinRound; //线段接头格式
    path.lineWidth = 8;

    
    //设置路径颜色  原理和设置填充颜色一样,这不过是调用[path stroke]方法来设置路径额颜色 设置线宽为8
    UIColor *blackColor = [UIColor blackColor];
    [blackColor set];
    [path stroke];
}

#pragma mark:由于设置填充颜色、线条颜色、线条宽度代码重复冗余,所以将其写到一个方法里,统一设置为填充颜色为红色,线条颜色为黑色,线条宽度为8
//绘制一个矩形
-(void)drawRectangle{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(40,40 ,k_CurrentWidth - 80 , k_CurrentHeight - 80)];
    [self setPath:path];
}

//绘制一个实心圆形
-(void)drawFillCircle{
    /*
      该方法是使用一个矩形为基准绘制其内切圆
      当该矩形是正方形时,绘制出的为圆形
      当该矩形为长方形的时候,绘制出来的是椭圆
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(40, 80, k_ScreenWidth - 80, k_ScreenWidth - 80)];
    [self setPath:path];
}

//绘制一个空心圆形  主要为了展示使用不同的工厂方法来创建圆形
-(void)drawEmptyCircle{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(k_ScreenWidth/2, k_CurrentHeight - 300) radius:(k_ScreenWidth - 40)/2
                                                    startAngle:0
                                                      endAngle:k_DegreesToRadians(360)
                                                     clockwise:YES];
    //设置填充颜色
    UIColor *redColor = [UIColor clearColor];
    [redColor set];
    [path fill];
    
    //设置路径格式
    path.lineWidth = 8;
    path.lineCapStyle = kCGLineJoinRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //设置路径颜色
    UIColor *blackColor = [UIColor blackColor];
    [blackColor set];
    [path stroke];
}

//绘制一个四个角都是圆角额矩形
-(void)drawCornerRectangle{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(40,40 ,k_CurrentWidth - 80 , k_CurrentHeight - 80)
                                                    cornerRadius:20];
    [self setPath:path];
}

//绘制一个可选角度的矩形
-(void)drawRectWithLeftAndRightCorner{
    /*
     参数解析:
     bezierPathWithRoundedRect   绘制矩形的大小
     byRoundingCorners           有哪几个角需要绘制
     cornerRadii                 圆角角度,使用角的顶点作为圆心来切圆角
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(40,40 ,k_CurrentWidth - 80 , k_CurrentHeight - 80)
                                               byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake((k_CurrentWidth - 80)/2, (k_CurrentWidth - 80)/2)];
    [self setPath:path];
}

- (void)drawSecondBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置一个起始点
    [path moveToPoint:CGPointMake(20, self.frame.size.height - 100)];
    // 添加二次曲线
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width - 20, self.frame.size.height - 100)
                 controlPoint:CGPointMake(self.frame.size.width / 2, 0)];
    
    path.lineCapStyle = kCGLineJoinRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 8.0;
    
    UIColor *strokeColor = [UIColor blackColor];
    [strokeColor set];
    [path stroke];
}

- (void)drawThirdBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)];
    
    [path addCurveToPoint:CGPointMake(300, 200)
            controlPoint1:CGPointMake(160, 50)
            controlPoint2:CGPointMake(160, 300)];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor blackColor];
    [strokeColor set];
    [path stroke];
}



-(void)setPath:(UIBezierPath*)path{
    //设置填充颜色
    UIColor *redColor = [UIColor redColor];
    [redColor set];
    [path fill];
    
    //设置路径格式
    path.lineWidth = 8.0;
    path.lineCapStyle = kCGLineJoinRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //设置路径颜色
    UIColor *blackColor = [UIColor blackColor];
    [blackColor set];
    [path stroke];
}

@end
