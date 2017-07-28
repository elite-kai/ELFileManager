//
//  ViewController.m
//  ELNSFileManager
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

- (IBAction)changeMClass:(id)sender {
    
    
    
    
    //这里面的方法可以自己定义，如果有第三方代码的话，也会添加进去，这没有做判断
    //只需要点击一次就可以了，如果多次点击，会产生重复的代码
    NSArray *array = @[@"- (NSMutableString *)viewWillString:(UIView *)vc withBtn:(NSMutableString *)btnstring{return btnstring;}",
                       @"- (UIBarButtonItem *)viewfromViewController:(NSString *)string withUrl:(NSURL *)url withBtn:(UIBarButtonItem *)btn{return btn;}",
                       @"+ (NSArray *)arrayChangeToString:(NSArray *)string{return string;}",
                       @"+ (UIImage *)stringToDic:(NSDictionary *)dic withArray:(UIImage *)array{return array;}",
                       @"+ (UIColor *)dicFromArray:(NSArray *)array withString:(UIColor *)string{return string;}"
                       ];
    
    NSMutableString *methodString = [NSMutableString string];
    for (NSString *method in array) {
        [methodString appendString:[NSString stringWithFormat:@"%@\n", method]];
    }
    
    NSString *method = [NSString stringWithFormat:@"%@@end", methodString];
    NSLog(@"method---------- %@", method);
    
    NSString *homePath = @"<#项目的地址，直接把项目拖进来#>";
    [self changeMFile:homePath withMethodName:method];
}


- (IBAction)changeFileName:(id)sender {
    
    //注意、修改文件夹名字的时候并没有与类的名字或者其他文件的名字做区分，所以这个地方大家要注意
    //如果图片名字也有LXK这个三个字母的话，那么也会一起修改了
    
    NSString *homePath = @"<#项目的地址，直接把项目拖进来#>";
    
    //比如TestProduct这个项目中的名字是LXK，然后这个地方就用LXK
    NSString *lastPath = @"<#项目中文件夹刚开始的名字，命名要统一#>";
    
    //修改后的名字，可以随便写，比如 LRGJ
    NSString *nowPath = @"<#修改后显示出来的文件夹的名字#>";
    
    //这里 “LXK” 开头的文件目录有几层就需要点击几下按钮，
    //比如目录结构 LXKMine->LXKVM->LXKImage->LXKLunch，就需要点击四下，所有的目录中，按照目录层级最多的那个次数点击
    //比如 LXKClass->LXKVM->LXKImage只有三层，所以按照LXKMine->LXKVM->LXKImage->LXKLunch的目录次数点击
    [self listFileAtPath:homePath withPath:lastPath withToPath:nowPath];
    
}


- (void)listFileAtPath:(NSString *)pathName withPath:(NSString *)lastPath withToPath:(NSString *)nowPath{
    
    NSArray *contentOfFolder = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathName error:NULL];
    for (NSString *aPath in contentOfFolder)
    {
        
        NSString *suffix = [aPath pathExtension];
        
        if (!([suffix isEqual:@"m"] || [suffix isEqual:@"h"]))
        {
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString * fullPath = [pathName stringByAppendingPathComponent:aPath];
            NSMutableString *path = [NSMutableString stringWithFormat:@"%@", fullPath];
            NSString *toPath = [path stringByReplacingOccurrencesOfString:lastPath withString:nowPath];
            [fileManager moveItemAtPath:path toPath:toPath error:NULL];
            
            BOOL isDir;
            if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir] && isDir)
            {
                [self listFileAtPath:fullPath withPath:lastPath withToPath:nowPath];
            }
        }
    }
}


- (void)changeMFile:(NSString *)pathName withMethodName:(NSString *)methodName
{
    NSMutableArray *fileArray = [NSMutableArray array];
    
    NSArray *contentOfFolder = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathName error:NULL];
    for (NSString *aPath in contentOfFolder) {
        
        NSString * fullPath = [pathName stringByAppendingPathComponent:aPath];
        NSMutableString *path = [NSMutableString stringWithFormat:@"%@", fullPath];
        [fileArray addObject:path];
        
        //从路径中获得完整的文件名 （带后缀）
        //            NSString *fileName = [path lastPathComponent];
        //            NSLog(@"fileName ********************* %@", fileName);
        //            //获得文件的后缀名 （不带'.'）
        //            NSString *suffix = [path pathExtension];
        //            NSLog(@"suffix------- %@", suffix);
        
        BOOL isDir;
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) {
            [self changeMFile:fullPath withMethodName:methodName];
        }
    }
    
    
    for (NSString *aPath in fileArray)
    {
        NSString *suffix = [aPath pathExtension];
        if ([suffix isEqualToString:@"m"])
        {
            NSString *content=[NSString stringWithContentsOfFile:aPath encoding:NSUTF8StringEncoding error:nil];
            
            NSMutableString *contentString = [NSMutableString stringWithFormat:@"%@", content];
            
            NSArray *endArray = [self rangeOfSubString:@"@end" inString:contentString];
            if (endArray.count > 0)
            {
                
                NSString *rangeString = endArray[endArray.count-1];
                NSRange range = NSRangeFromString(rangeString);
                NSString *noEndString = [contentString stringByReplacingCharactersInRange:range withString:@""];
                NSMutableString *endString = [NSMutableString stringWithFormat:@"%@", noEndString];
                NSString *string = [endString stringByAppendingString:methodName];
                
                BOOL res=[string writeToFile:aPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
                if (res) {
                    
                    NSLog(@"文件写入成功");
                    
                }else
                    
                    NSLog(@"文件写入失败");
                
            }
            
        }
    }
    
}


- (NSArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string {
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    
    NSString *string1 = [string stringByAppendingString:subStr];
    
    NSString *temp;
    
    for (int i = 0; i < string.length; i ++) {
        
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        
        if ([temp isEqualToString:subStr]) {
            
            NSRange range = {i,subStr.length};
            
            [rangeArray addObject:NSStringFromRange(range)];
            
        }
        
    }
    
    return rangeArray;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
