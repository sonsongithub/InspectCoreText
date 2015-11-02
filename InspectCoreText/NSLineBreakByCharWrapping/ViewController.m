//
//  ViewController.m
//  CoreTextBug01
//
//  Created by sonson on 2014/09/14.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"

@implementation NSParagraphStyle (ViewController)

+ (NSParagraphStyle*)defaultParagraphStyleWithFontSize:(float)fontSize {
	NSMutableParagraphStyle  *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
	paragraphStyle.alignment = NSTextAlignmentLeft;
	paragraphStyle.maximumLineHeight = fontSize + 1;
	paragraphStyle.minimumLineHeight = fontSize + 1;
	paragraphStyle.lineSpacing = 1;
	paragraphStyle.paragraphSpacing = 1;
	paragraphStyle.paragraphSpacingBefore = 1;
	paragraphStyle.lineHeightMultiple = 0;
	return paragraphStyle;
}

@end

@interface NSLineBreakByCharWrappingViewController () {
	IBOutlet TestView *_good;
	IBOutlet TestView *_bad;
	IBOutlet TestView *_test;
}
@end

@implementation NSLineBreakByCharWrappingViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSString *string = @"abcdef  \ngh\n i";
	
	CGFloat fontSize = 20;
	
	NSParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyleWithFontSize:fontSize];
	NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
	
	_bad.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	_test.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	_good.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
