//
//  ViewController.swift
//  snapchat-color-picker
//
//  Created by Florent TM on 10/04/2016.
//  Copyright © 2016 Florent THOMAS-MOREL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FTColorPickerRecognizerDelegate {

    var kPercentToTop:CGFloat       = 0.09
    var kPercentRange:CGFloat       = 0.025
    var kPercentToBottom:CGFloat    = 0.2
    var kPercentToLeft:CGFloat      = 0.35
    var kPercentToWhite:CGFloat     = 0.07
    
    let kColorPicker = UIImage(named:"color_picker")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorPicker = FTColorPickerRecognizer(view:self.view, withImagePicker: true)
        colorPicker.delegate = self
        self.view.addSubview(colorPicker)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didChangeColor(color: UIColor) {
        self.view.backgroundColor = color
    }
}
