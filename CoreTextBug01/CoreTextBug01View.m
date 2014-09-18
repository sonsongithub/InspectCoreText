//
//  CoreTextBug01View.m
//  CoreTextBug01
//
//  Created by sonson on 2014/09/14.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "CoreTextBug01View.h"

#import <CoreText/CoreText.h>

#define	DNSLog(...)		NSLog(__VA_ARGS__);
#define DNSLogMethod	NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd));
#define DNSLogPoint(p)	NSLog(@"%f,%f", p.x, p.y);
#define DNSLogSize(p)	NSLog(@"%f,%f", p.width, p.height);
#define DNSLogRect(p)	NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);
#define DNSLogEdgeInsets(p)	NSLog(@"%f,%f %f,%f", p.top, p.left, p.bottom, p.right);
#define DNSLogMainThread if ([NSThread isMainThread]){NSLog(@"This is the main thread.");}else{NSLog(@"This is a sub thread.");}

#define SAFE_CFRELEASE(p) if(p){CFRelease(p);p=NULL;}

@interface CoreTextBug01View() {
	NSAttributedString				*_attributedString;
	CTFramesetterRef				_framesetter;
	CTFrameRef						_frame;
	CGRect							_contentRect;
	CFStringTokenizerRef			_tokenizer;
}
@end


@implementation CoreTextBug01View

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	
	[[UIColor blueColor] setFill];
	CGContextFillRect(context, _contentRect);
	[self drawStringRectForDebug];
	
	CGContextTranslateCTM(context, 0, 0);

	// draw text
#if 1
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, 0, _contentRect.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CTFrameDraw(_frame, context);
	CGContextRestoreGState(context);
#else
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, 0, self.frame.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CTFrameDraw(_frame, context);
	CGContextRestoreGState(context);
#endif
}

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

- (void)drawStringRectForDebug {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
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
	
//	frameSize.width += 10;
	
	_contentRect = CGRectZero;
	_contentRect.size = frameSize;

	DNSLogSize(frameSize);
	DNSLogRect(self.bounds);
	
	CGMutablePathRef path = CGPathCreateMutable();
//	CGPathAddRect(path, NULL, self.bounds);
	CGPathAddRect(path, NULL, _contentRect);
	_frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), path, NULL);
	CGPathRelease(path);
	
	_contentRect.size.height = [self getSizeRestrictly];
	
	[self setNeedsDisplay];
}

@end
