//
//  TestView.m
//  CoreTextBug01
//
//  Created by sonson on 2014/09/28.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawStringRectForDebug {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (_frame == nil)
		return;
	
	CFArrayRef lines = CTFrameGetLines(_frame);
	CFIndex lineCount = CFArrayGetCount(lines);
	CGPoint lineOrigins[lineCount];
	CTFrameGetLineOrigins(_frame, CFRangeMake(0, 0), lineOrigins);
	
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
		lineRect.origin.y = _contentRect.size.height - CGRectGetMaxY(lineRect);
		CGContextStrokeRect(context, lineRect);
	}
}

- (void)setAttributedString:(NSAttributedString *)attributedString {
	_attributedString = attributedString;
	[self update];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// attribute
	[[UIColor yellowColor] setFill];
	CGContextFillRect(context, _contentRect);
	[self drawStringRectForDebug];
	
	// draw text
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, 0, _contentRect.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CTFrameDraw(_frame, context);
	CGContextRestoreGState(context);
}

- (void)update {
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
	
	CGFloat constrainedWidth = self.frame.size.width;
	CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(_framesetter,
																	CFRangeMake(0, _attributedString.length),
																	NULL,
																	CGSizeMake(constrainedWidth, CGFLOAT_MAX),
																	NULL);
	_contentRect = CGRectZero;
	_contentRect.size = frameSize;
	_contentRect.size.width = constrainedWidth;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, _contentRect);
	_frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), path, NULL);
	CGPathRelease(path);
	
	[self setNeedsDisplay];
}

@end
