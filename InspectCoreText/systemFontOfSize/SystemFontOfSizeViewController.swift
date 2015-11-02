//
//  SystemFontOfSizeViewController.swift
//  InspectCoreText
//
//  Created by sonson on 2015/11/02.
//  Copyright © 2015年 sonson. All rights reserved.
//

import UIKit

class SystemFontOfSizeViewController: UIViewController {
    @IBOutlet var textView:TextView? = nil
    @IBOutlet var segment:UISegmentedControl? = nil
    var backview:UIView? = nil
    
    @IBAction func didChange(sender:AnyObject) {
        if let segment = segment {
            if segment.selectedSegmentIndex == 0 {
                updateContent(UIFont.systemFontOfSize(12))
            }
            else if segment.selectedSegmentIndex == 1 {
                //                updateContent(UIFont(name: ".SFUIText-Light", size: 12)!)
                updateContent(UIFont(name: "HiraginoSans-W3", size:12)!)
            }
        }
    }
    
    func updateContent(renderingFont:UIFont) {
        let width:CGFloat = 340
        let font = renderingFont
        
        guard let path = NSBundle.mainBundle().pathForResource("data.txt", ofType: nil) else { return }
        guard let data = NSData(contentsOfFile: path) else { return }
        guard let source = NSString(data: data, encoding: NSUTF8StringEncoding) as? String else { return }
        let attr = NSMutableAttributedString(string: source)
        
        attr.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attr.length))
        
        if let textView = textView {
            textView.setContent(attr, width: 340)
        }
        //        let framesetter = CTFramesetterCreateWithAttributedString(attr)
        //
        //        let frameSize = CTFramesetterSuggestFrameSizeWithConstraints(
        //            framesetter,
        //            CFRangeMake(0, attr.length),
        //            nil,
        //            CGSizeMake(width, CGFloat.max),
        //            nil)
        //        var rect = CGRectMake(0, 20, 0, 0)
        //        rect.size = frameSize
        //
        //
        //        if let backview = backview {
        //            backview.removeFromSuperview()
        //        }
        //        let view = UIView(frame: rect)
        //        self.view.addSubview(view)
        //        view.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)
        //        backview = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateContent(UIFont.systemFontOfSize(12))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
