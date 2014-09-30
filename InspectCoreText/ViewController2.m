//
//  ViewController2.m
//  InspectCoreText
//
//  Created by sonson on 2014/09/30.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "ViewController2.h"
#import "TestView.h"

@implementation NSParagraphStyle (ViewController)

+ (NSParagraphStyle*)defaultParagraphStyleWithFontSize:(float)fontSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
	NSMutableParagraphStyle  *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineBreakMode = lineBreakMode;
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

@interface ViewController2 () {
	IBOutlet TestView *_char;
	IBOutlet TestView *_word;
	IBOutlet TestView *_other;
}
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Do any additional setup after loading the view, typically from a nib.
	
	NSString *string = @"abcdef  \ngh\n i";
	
	CGFloat fontSize = 20;
	
	{
		NSParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyleWithFontSize:fontSize lineBreakMode:NSLineBreakByCharWrapping];
		NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
		_char.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	}
	{
		NSParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyleWithFontSize:fontSize lineBreakMode:NSLineBreakByWordWrapping];
		NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
		_word.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	}
	{
		NSParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyleWithFontSize:fontSize lineBreakMode:NSLineBreakByClipping];
		NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
		_other.attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
	}
}

@end
