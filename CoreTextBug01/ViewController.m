//
//  ViewController.m
//  CoreTextBug01
//
//  Created by sonson on 2014/09/14.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "ViewController.h"
#import "CoreTextBug01View.h"

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
	IBOutlet CoreTextBug01View *_textView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"bug_data.bin" ofType:nil];
	NSData *data = [NSData dataWithContentsOfFile:path];
	
	NSString *string = [[NSString alloc] initWithCharacters:[data bytes] length:[data length]/sizeof(unichar)];
	
	string = @"hoge\na";
	
	CGFloat fontSize = 20;
	
	NSParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyleWithFontSize:fontSize];
	NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
	
	_textView.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	[_textView update];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
