//
//  BadTestView.m
//  CoreTextBug01
//
//  Created by sonson on 2014/09/28.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "BadTestView.h"

@implementation BadTestView

- (void)update {
	// CoreText
	SAFE_CFRELEASE(_framesetter);
	SAFE_CFRELEASE(_frame);
	
	CFAttributedStringRef p = (__bridge CFAttributedStringRef)_attributedString;
	if (p) {
		_framesetter = CTFramesetterCreateWithAttributedString(p);
	}
	else {
		p = CFAttributedStringCreate(NULL, CFSTR(""), NULL);
		_framesetter = CTFramesetterCreateWithAttributedString(p);
		CFRelease(p);
	}
	
	CGFloat width = self.frame.size.width;
	
	CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(_framesetter,
																	CFRangeMake(0, _attributedString.length),
																	NULL,
																	CGSizeMake(width, CGFLOAT_MAX),
																	NULL);
	
	_contentRect = CGRectZero;
	_contentRect.size = frameSize;
	
	DNSLogSize(frameSize);
	DNSLogRect(self.bounds);
	
	CGMutablePathRef path = CGPathCreateMutable();
	//	CGPathAddRect(path, NULL, self.bounds);
	CGPathAddRect(path, NULL, _contentRect);
	_frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), path, NULL);
	CGPathRelease(path);
	
	[self setNeedsDisplay];
}

@end
