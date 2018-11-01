//
//  UILabel Extension.swift
//  Bantu
//
//  Created by Kensen Tjoa on 31/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    func setDynamic(fontFamily: String, size: CGFloat, style: String, type: UIFont.TextStyle){
        
        var font: UIFont?
        if style == "bold" {
            font = UIFont(name: fontFamily, size: size)?.bold()
        } else {
            font = UIFont(name: fontFamily, size: size)
        }
        
        var fontMetrics: UIFontMetrics?
        fontMetrics = UIFontMetrics(forTextStyle: type)
        
        
        self.font = fontMetrics!.scaledFont(for: font!)
        self.adjustsFontForContentSizeCategory = true
    }
}

extension UITextView{
    func setDynamic(fontFamily: String, size: CGFloat, style: String, type: UIFont.TextStyle){
        
        var font: UIFont?
        if style == "bold" {
            font = UIFont(name: fontFamily, size: size)?.bold()
        } else {
            font = UIFont(name: fontFamily, size: size)
        }
        
        var fontMetrics: UIFontMetrics?
        fontMetrics = UIFontMetrics(forTextStyle: type)
        
        
        self.font = fontMetrics!.scaledFont(for: font!)
        self.adjustsFontForContentSizeCategory = true
    }
}


extension UIButton {
    
    func setDynamic(fontFamily: String, size: CGFloat, style: String, type: UIFont.TextStyle){
        
        var font: UIFont?
        if style == "bold" {
            font = UIFont(name: fontFamily, size: size)?.bold()
        } else {
            font = UIFont(name: fontFamily, size: size)
        }
        
        var fontMetrics: UIFontMetrics?
        fontMetrics = UIFontMetrics(forTextStyle: type)
        
        self.titleLabel?.font = fontMetrics!.scaledFont(for: font!)
        self.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}


extension UITextField {
    func setDynamic(fontFamily: String, size: CGFloat, style: String, type: UIFont.TextStyle){
        
        var font: UIFont?
        if style == "bold" {
            font = UIFont(name: fontFamily, size: size)?.bold()
        } else {
            font = UIFont(name: fontFamily, size: size)
        }
        
        var fontMetrics: UIFontMetrics?
        fontMetrics = UIFontMetrics(forTextStyle: type)
        
        
        self.font = fontMetrics!.scaledFont(for: font!)
        self.adjustsFontForContentSizeCategory = true
    }
}
