//
//  TestView.h
//  CoreTextBug01
//
//  Created by sonson on 2014/09/28.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <CoreText/CoreText.h>

#define	DNSLog(...)		NSLog(__VA_ARGS__);
#define DNSLogMethod	NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd));
#define DNSLogPoint(p)	NSLog(@"%f,%f", p.x, p.y);
#define DNSLogSize(p)	NSLog(@"%f,%f", p.width, p.height);
#define DNSLogRect(p)	NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);
#define DNSLogEdgeInsets(p)	NSLog(@"%f,%f %f,%f", p.top, p.left, p.bottom, p.right);
#define DNSLogMainThread if ([NSThread isMainThread]){NSLog(@"This is the main thread.");}else{NSLog(@"This is a sub thread.");}

#define SAFE_CFRELEASE(p) if(p){CFRelease(p);p=NULL;}

@interface TestView : UIView {
	NSAttributedString				*_attributedString;
	CTFramesetterRef				_framesetter;
	CTFrameRef						_frame;
	CGRect							_contentRect;
	CFStringTokenizerRef			_tokenizer;
}
@property (nonatomic, copy) NSAttributedString *attributedString;
- (void)update;
@end
