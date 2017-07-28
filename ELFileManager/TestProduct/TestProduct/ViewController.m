//
//  ViewController.m
//  TestProduct
//
//  Created by Parkin on 2017/7/28.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSMutableString *)viewWillString:(UIView *)vc withBtn:(NSMutableString *)btnstring{return btnstring;}
- (UIBarButtonItem *)viewfromViewController:(NSString *)string withUrl:(NSURL *)url withBtn:(UIBarButtonItem *)btn{return btn;}
+ (NSArray *)arrayChangeToString:(NSArray *)string{return string;}
+ (UIImage *)stringToDic:(NSDictionary *)dic withArray:(UIImage *)array{return array;}
+ (UIColor *)dicFromArray:(NSArray *)array withString:(UIColor *)string{return string;}
@end