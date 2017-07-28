//
//  LXKView.m
//  TestProduct
//
//  Created by Parkin on 2017/7/28.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "LXKView.h"

@implementation LXKView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (NSMutableString *)viewWillString:(UIView *)vc withBtn:(NSMutableString *)btnstring{return btnstring;}
- (UIBarButtonItem *)viewfromViewController:(NSString *)string withUrl:(NSURL *)url withBtn:(UIBarButtonItem *)btn{return btn;}
+ (NSArray *)arrayChangeToString:(NSArray *)string{return string;}
+ (UIImage *)stringToDic:(NSDictionary *)dic withArray:(UIImage *)array{return array;}
+ (UIColor *)dicFromArray:(NSArray *)array withString:(UIColor *)string{return string;}
@end