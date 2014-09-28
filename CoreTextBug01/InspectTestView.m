//
//  InspectTestView.m
//  CoreTextBug01
//
//  Created by sonson on 2014/09/28.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "InspectTestView.h"

@implementation InspectTestView

- (float)getSizeRestrictly {
	CFArrayRef lines = CTFrameGetLines(_frame);
	CFIndex lineCount = CFArrayGetCount(lines);
	CGPoint lineOrigins[lineCount];
	CTFrameGetLineOrigins(_frame, CFRangeMake(0, 0), lineOrigins);
	
	CGFloat height = 0;
	
	for (NSInteger index = 0; index < lineCount; index++) {
		CGPoint origin = lineOrigins[index];
		CTLineRef line = CFArrayGetValueAtIndex(lines, index);
		
		CGFloat ascent;
		CGFloat descent;
		CGFloat leading;
		CGFloat width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
		
		CGRect lineRect = CGRectMake(origin.x,
									 ceilf(origin.y - descent),
									 width,
									 ceilf(ascent + descent));
		height = (lineRect.origin.y + lineRect.size.height);
		return height;
	}
	return height;
}

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
	CGFloat temp = frameSize.width;
	
	frameSize = CTFramesetterSuggestFrameSizeWithConstraints(_framesetter,
																	CFRangeMake(0, _attributedString.length),
																	NULL,
																	CGSizeMake(frameSize.width, CGFLOAT_MAX),
																	NULL);
	
	_contentRect = CGRectZero;
	_contentRect.size = frameSize;
	frameSize.width = temp;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, _contentRect);
	_frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), path, NULL);
	CGPathRelease(path);
	
	[self setNeedsDisplay];
}

@end
