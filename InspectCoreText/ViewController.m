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

@interface ViewController () {
	IBOutlet TestView *_good;
	IBOutlet TestView *_bad;
	IBOutlet TestView *_test;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSString *string = @"abcdef  \ngh\n ";
	
	CGFloat fontSize = 20;
	
	NSParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyleWithFontSize:fontSize];
	NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
	
	_bad.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	[_bad update];
	
	_test.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	[_test update];
	
	_good.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	[_good update];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
