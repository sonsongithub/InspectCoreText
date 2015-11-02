//
//  TextView.swift
//  fontTest
//
//  Created by sonson on 2015/11/02.
//  Copyright © 2015年 sonson. All rights reserved.
//

import UIKit

class TextView: UIView {
    var attributedString:NSAttributedString? = nil
    var framesetter:CTFramesetter? = nil
    var ctframe:CTFrameRef? = nil
    var contentRect = CGRectZero
    
    func setContent(newAttributedString:NSAttributedString, width:CGFloat) {
        
        let newframesetter = CTFramesetterCreateWithAttributedString(newAttributedString);
        
        let size = CTFramesetterSuggestFrameSizeWithConstraints(
            newframesetter,
            CFRangeMake(0, newAttributedString.length),
            nil,
            CGSizeMake(width, CGFloat.max),
            nil)
        
        contentRect = CGRectZero
        contentRect.size = size
        
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, contentRect)
        let newFrame = CTFramesetterCreateFrame(newframesetter, CFRangeMake(0, 0), path, nil)
        
        attributedString = newAttributedString
        framesetter = newframesetter
        ctframe = newFrame
        
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        if let ctframe = ctframe, let context = UIGraphicsGetCurrentContext() {
            // draw text
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 0, contentRect.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextSetTextMatrix(context, CGAffineTransformIdentity);
            CTFrameDraw(ctframe, context);
            CGContextRestoreGState(context);
        }
    }
}