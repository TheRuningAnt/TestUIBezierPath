//
//  Test_UIBezierPathView.h
//  TestUIBezierPath
//
//  Created by 赵广亮 on 16/7/23.
//  Copyright © 2016年 zhaoguangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define k_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define k_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define k_CurrentHeight self.frame.size.height
#define k_CurrentWidth self.frame.size.width
#define Pi 3.1415926
#define k_DegreesToRadians(degrees) ((Pi * degrees)/ 180)


typedef CF_ENUM(NSInteger,LLBezierPahtEnum){
    kBezierDrawTriangle = 1,
    kBezierDrawRect = 2,
    kBezierDrawFillCircle = 3,
    kBezierDrawEmptyCircle = 4,
    kBezierDrawCornerRect = 5,
    kBezierDrawCornerRectOfLeftAndRight = 6,
    kBezierDrawSecondBezierPath = 7,
    kBezierDrawThirdBezierPath = 8,
    
};

@interface Test_UIBezierPathView : UIView

-(void)drawBezierPathWithType:(LLBezierPahtEnum)type;
@end
