//
//  FTColorPickerRecognizer.swift
//  snapchat-color-picker
//
//  Created by Florent TM on 21/04/2016.
//  Copyright © 2016 Florent THOMAS-MOREL. All rights reserved.
//

import Foundation
import UIKit

protocol FTColorPickerRecognizerDelegate{
    func didChangeColor(color:UIColor)
}

class FTColorPickerRecognizer:UIView{
    
    var kPercentToTop:CGFloat       = 0.09
    var kPercentRange:CGFloat       = 0.025
    var kPercentToBottom:CGFloat    = 0.2
    var kPercentToLeft:CGFloat      = 0.35
    var kPercentToWhite:CGFloat     = 0.07
    
    var delegate:FTColorPickerRecognizerDelegate?
    
    let kColorPicker = UIImage(named:"color_picker")
    
    init(view:UIView, withImagePicker isVisible:Bool = true){
        super.init(frame: view.frame)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FTColorPickerRecognizer.handlePanGesture(_:)))
        self.addGestureRecognizer(panGestureRecognizer)
        
        if isVisible {
            let imageView = UIImageView(frame: CGRectMake(self.frame.width-25, self.frame.size.height*kPercentToTop, 15, 6*kPercentRange*self.frame.size.height))
            imageView.image = kColorPicker
            imageView.contentMode = .ScaleToFill
            imageView.layer.cornerRadius = 5
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.whiteColor().CGColor
            imageView.layer.borderWidth = 2
            
            self.addSubview(imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handlePanGesture(gesture:UIPanGestureRecognizer){
        switch gesture.state {
        case .Began:
            didChangeGesture(gesture)
            break
        case .Changed:
            didChangeGesture(gesture)
            break
        default: break
        }
    }
    
    func didChangeGesture(gesture:UIPanGestureRecognizer){
        let position = gesture.locationInView(self)
        let color = getColorFromPosition(position)
        self.delegate?.didChangeColor(color)
        
    }
    
    
    func getColorFromPosition(position:CGPoint) -> UIColor{
        var red:CGFloat = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat = 0.0
        
        let kConstraintToTop = self.frame.size.height * kPercentToTop
        let kConstraintRange = self.frame.size.height * kPercentRange
        let kConstraintToBottom = self.frame.size.height * kPercentToBottom
        let kConstraintToLeft = self.frame.size.width * kPercentToLeft
        let kConstraintToWhite = self.frame.size.width * kPercentToWhite
        
        //Get Color Part
        if position.y < kConstraintToTop{
            red = 1.0
            green = 0.0
            blue = 0.0
        }
        else if position.y-kConstraintToTop < kConstraintRange{
            red = 1.0
            green = 0.0
            blue = (position.y-kConstraintToTop)/kConstraintRange
        }
        else if position.y-kConstraintToTop < 2*kConstraintRange{
            red = 1-(position.y-(kConstraintToTop + 1*kConstraintRange))/kConstraintRange
            green = 0.0
            blue = 1.0
        }
        else if position.y-kConstraintToTop < 3*kConstraintRange{
            red = 0.0
            green = (position.y-(kConstraintToTop + 2*kConstraintRange))/kConstraintRange
            blue = 1.0
        }
        else if position.y-kConstraintToTop < 4*kConstraintRange{
            red = 0.0
            green = 1.0
            blue = 1-(position.y-(kConstraintToTop + 3*kConstraintRange))/kConstraintRange
        }
        else if position.y-kConstraintToTop < 5*kConstraintRange{
            red = (position.y-(kConstraintToTop + 4*kConstraintRange))/kConstraintRange
            green = 1.0
            blue = 0.0
        }
        else if position.y-kConstraintToTop < 6*kConstraintRange{
            red = 1.0
            green = 1-(position.y-(kConstraintToTop + 5*kConstraintRange))/kConstraintRange
            blue = 0.0
        }else{
            red = 1.0
            green = 0.0
            blue = 0.0
        }
        
        //Get White Part
        if position.x < kConstraintToLeft{
            let distanceToWhiteForRed = kConstraintToLeft*(1-red)
            red = min(1,(kConstraintToLeft - (position.x - kConstraintToWhite))/distanceToWhiteForRed)
            let distanceToWhiteForGreen = kConstraintToLeft*(1-green)
            green = min(1,(kConstraintToLeft - (position.x - kConstraintToWhite))/distanceToWhiteForGreen)
            let distanceToWhiteForBlue = kConstraintToLeft*(1-blue)
            blue = min(1,(kConstraintToLeft - (position.x - kConstraintToWhite))/distanceToWhiteForBlue)
        }
        
        //Get Black Part
        if position.y > self.frame.size.height - kConstraintToBottom{
            red -= min(1,abs(position.y-self.frame.size.height+kConstraintToBottom)/(kConstraintToBottom-kConstraintToTop))
            green -= min(1,abs(position.y-self.frame.size.height+kConstraintToBottom)/(kConstraintToBottom-kConstraintToTop))
            blue -= min(1,abs(position.y-self.frame.size.height+kConstraintToBottom)/(kConstraintToBottom-kConstraintToTop))
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}