//
//  ViewController.m
//  DynamicViewGenerator
//
//  Created by Martin on 4/1/15.
//  Copyright (c) 2015 Martin. All rights reserved.
//

#import "ViewController.h"
#import "ObjectCreater.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"DynamicViewList" ofType:@"plist"];
    NSDictionary * contentDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    [ObjectCreater initWithObject:contentDictionary inView:self.view];
    
    // For Understand View Level.
    for (id subviews in [self.view subviews]) {
        NSLog(@"->%@",NSStringFromClass([subviews class]));
        if ([subviews isKindOfClass:[UIView class]]) {
            for (id subviews1 in [subviews subviews]) {
                NSLog(@"-->%@",NSStringFromClass([subviews1 class]));
            }
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
