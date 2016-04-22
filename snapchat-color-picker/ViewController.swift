//
//  ViewController.swift
//  snapchat-color-picker
//
//  Created by Florent TM on 10/04/2016.
//  Copyright © 2016 Florent THOMAS-MOREL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FTColorPickerRecognizerDelegate {

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
