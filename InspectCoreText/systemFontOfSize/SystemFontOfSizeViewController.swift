//
//  SystemFontOfSizeViewController.swift
//  InspectCoreText
//
//  Created by sonson on 2015/11/02.
//  Copyright © 2015年 sonson. All rights reserved.
//

import UIKit

class SystemFontOfSizeViewController: UIViewController {
    @IBOutlet var textView: TextView? = nil
    @IBOutlet var segment: UISegmentedControl? = nil
    var backview: UIView? = nil

    @IBAction func didChange(sender: AnyObject) {
        if let segment = segment {
            if segment.selectedSegmentIndex == 0 {
                updateContent(UIFont.systemFontOfSize(12))
            } else if segment.selectedSegmentIndex == 1 {
                let font = UIFont.systemFontOfSize(12)
                updateContent(UIFont(name: font.fontName, size:12)!)
            }
        }
    }

    func updateContent(renderingFont: UIFont) {
        guard let path = NSBundle.mainBundle().pathForResource("data.txt", ofType: nil) else { return }
        guard let data = NSData(contentsOfFile: path) else { return }
        guard let source = NSString(data: data, encoding: NSUTF8StringEncoding) as? String else { return }
        let attr = NSMutableAttributedString(string: source)

        attr.addAttribute(NSFontAttributeName, value: renderingFont, range: NSMakeRange(0, attr.length))

        if let textView = textView {
            textView.setContent(attr, width: 340)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateContent(UIFont.systemFontOfSize(12))
        let font = UIFont.systemFontOfSize(12)
        segment?.setTitle(font.fontName, forSegmentAtIndex: 1)
    }
}
