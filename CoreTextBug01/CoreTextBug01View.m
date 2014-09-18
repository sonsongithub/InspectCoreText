//
//  CoreTextBug01View.m
//  CoreTextBug01
//
//  Created by sonson on 2014/09/14.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "CoreTextBug01View.h"

#import <CoreText/CoreText.h>

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
	
	CGContextTranslateCTM(context, 0, 0);
	
	// draw text
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, 0, _contentRect.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CTFrameDraw(_frame, context);
	CGContextRestoreGState(context);
	
	
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
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, _contentRect);
	_frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), path, NULL);
	CGPathRelease(path);
	
	[self setNeedsDisplay];
}

@end
