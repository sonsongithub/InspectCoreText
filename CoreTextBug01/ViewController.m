//
//  ViewController.m
//  CoreTextBug01
//
//  Created by sonson on 2014/09/14.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "ViewController.h"
#import "CoreTextBug01View.h"

@interface ViewController () {
	IBOutlet CoreTextBug01View *_textView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_textView.attributedString = [[NSAttributedString alloc] initWithString:@"hoge"];
	[_textView update];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
